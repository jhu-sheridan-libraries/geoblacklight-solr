resource "aws_cloudwatch_log_group" "hello_world" {
  name              = "hello_world"
  retention_in_days = 1
}

resource "aws_ecs_task_definition" "hello_world" {
  family = "hello_world"
  container_definitions = <<EOF
[
  {
    "name": "hello_world2",
    "image": "${var.container_id}",
    "portMappings": [
      {
        "containerPort": 8983,
        "hostPort": 8983      
      },
      {
        "containerPort": 5000,
        "hostPort": 5000      
      }
    ],
    "memory": 1907,
    "cpu": 1024,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "${var.region}",
        "awslogs-group": "hello_world",
        "awslogs-stream-prefix": "complete-ecs"
      }
    }
  }
]
EOF
}