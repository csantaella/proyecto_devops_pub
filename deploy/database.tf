resource "aws_db_subnet_group" "main" {
  name = "${local.prefix}-main"
  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.prefix}-main"
    }
  )
}

resource "aws_security_group" "rds" {
  description = "Allow access to the RDS database instance."
  name        = "${local.prefix}-rds-inbound-access"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol  = "tcp"
    from_port = 3306
    to_port   = 3306
    security_groups = [
      aws_security_group.bastion.id,
      aws_security_group.ecs_service.id,
    ]
  }

  tags = local.common_tags
}

resource "aws_db_instance" "main" {
  engine                  = "mysql"
  identifier              = "${local.prefix}-db"
  db_name                 = "prueba"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine_version          = "8.0.32"
  instance_class          = "db.t3.micro"
  manage_master_user_password   = false
  master_user_secret_kms_key_id = "Admin2033"
  password                = var.db_password
  username                = var.db_username
  backup_retention_period = 0
  db_subnet_group_name    = aws_db_subnet_group.main.name
  multi_az                = false
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.rds.id]
  publicly_accessible     = true

  tags = merge(
    local.common_tags,
    {
      Name = "${local.prefix}-main"
    }
  )
}
