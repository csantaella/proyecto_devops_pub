[
    {
        "name": "api",
        "image": "${app_image}",
        "essential": true,
        "memoryReservation": 256,
        "environment": [
            {"name": "DB_HOST", "value": "${db_host}"},
            {"name": "DB_NAME", "value": "${db_name}"},
            {"name": "DB_USER", "value": "${db_user}"},
            {"name": "DB_PASS", "value": "${db_pass}"},
            {"name": "ALLOWED_HOSTS", "value": "${allowed_hosts}"}
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "${log_group_name}",
                "awslogs-region": "${log_group_region}",
                "awslogs-stream-prefix": "api"
            }
        },
 #       "portMappings": [
 #           {
 #               "containerPort": 9000,
 #               "hostPort": 9000
 #           }
 #       ],
        "mountPoints": [
            {
                "readOnly": false,
                "containerPath": "/vol/web",
                "sourceVolume": "static"
            }
        ]
    },
    {
        "name": "proxy",
        "image": "${proxy_image}",
        "essential": true,
        "portMappings": [
            {
                "containerPort": 80,
                "hostPort": 8000
            }
        ],
        "memoryReservation": 256,
        "environment": [
            {"name": "APP_HOST", "value": "127.0.0.1"},
            {"name": "APP_PORT", "value": "9000"},
            {"name": "LISTEN_PORT", "value": "8000"}
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "${log_group_name}",
                "awslogs-region": "${log_group_region}",
                "awslogs-stream-prefix": "proxy"
            }
        },
        "mountPoints": [
            {
                "readOnly": true,
                "containerPath": "/vol/static",
                "sourceVolume": "static"
            }
        ]
    }
]
