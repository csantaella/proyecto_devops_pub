resource "aws_ecs_cluster" "main" {
  name = "${local.prefix}-cluster"

  tags = local.common_tags
}

# LAS 3 PRIMERAS ENTRADAS ASIGNAN LOS PERMISOS PARA PODER ARRANCAR TAREAS

#Añadimos una IAM Policy para las task Executio role policy para en el futuro arrancar una Task
resource "aws_iam_policy" "task_execution_role_policy" {
  name        = "${local.prefix}-task-exec-role-policy"
  path        = "/"
  description = "Allow retrieving images and adding to logs"
  policy      = file("./templates/ecs/task-exec-role.json")
}

# Defino un IAM Role
resource "aws_iam_role" "task_execution_role" {
  name               = "${local.prefix}-task-exec-role"
  assume_role_policy = file("./templates/ecs/assume-role-policy.json")
  tags               = local.common_tags
}

# Asociamos la política creada a el role: "task_execution_role_policy"
resource "aws_iam_role_policy_attachment" "task_execution_role" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = aws_iam_policy.task_execution_role_policy.arn
}

# Damos permisos a nuestra Task para que los utilice durante el Run time,
# los permisos que necesita el contenedor docker después de arrancar
resource "aws_iam_role" "app_iam_role" {
  name               = "${local.prefix}-api-task"
  assume_role_policy = file("./templates/ecs/assume-role-policy.json")
  tags               = local.common_tags
}

# Agrupación de los log generados por los contenedores en CloudWatch
resource "aws_cloudwatch_log_group" "ecs_task_logs" {
  name = "${local.prefix}-api"

  tags = local.common_tags
}

data "template_file" "api_container_definitions" {
  template = file("templates/ecs/container-definitions.json.tpl")

  vars = {
    app_image   = var.ecr_image_api
    proxy_image = var.ecr_image_proxy

    db_host = aws_db_instance.main.address
    db_user          = aws_db_instance.main.username
    db_pass          = aws_db_instance.main.password
    db_name          = aws_db_instance.main.db_name
    log_group_name   = aws_cloudwatch_log_group.ecs_task_logs.name
    log_group_region = data.aws_region.current.name
    allowed_hosts    = "*"
  }
}

resource "aws_ecs_task_definition" "api" {
  family                   = "${local.prefix}-api"
  container_definitions    = data.template_file.api_container_definitions.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  task_role_arn            = aws_iam_role.app_iam_role.arn
  volume {
    name = "static"
  }

  tags = local.common_tags
}

resource "aws_security_group" "ecs_service" {
  description = "Access for the ECS service"
  name        = "${local.prefix}-ecs-service"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    cidr_blocks = [
      aws_subnet.private_a.cidr_block,
      aws_subnet.private_b.cidr_block,
    ]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [
          aws_security_group.lb.id
      ]

  }

  tags = local.common_tags
}

resource "aws_ecs_service" "api" {
  name            = "${local.prefix}-api"
  cluster         = aws_ecs_cluster.main.name
  task_definition = aws_ecs_task_definition.api.family
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [
      aws_subnet.private_a.id,
      aws_subnet.private_b.id,
    ]
    security_groups  = [aws_security_group.ecs_service.id]
  }
  load_balancer {
        target_group_arn = aws_lb_target_group.api.arn
        container_name   = "proxy"
        container_port   = 80
    }
#  depends_on = [aws_lb_listener.api_https]
}

