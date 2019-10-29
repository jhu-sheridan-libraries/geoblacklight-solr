resource "aws_cloudwatch_log_group" "geoblacklight_solr" {
  name              = "geoblacklight_solr"
  retention_in_days = 1
}

resource "aws_ecs_task_definition" "geoblacklight_solr" {
  family = "geoblacklight_solr"
  container_definitions = <<EOF
[
  {
    "name": "solr",
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
        "awslogs-group": "geoblacklight_solr",
        "awslogs-stream-prefix": "complete-ecs"
      }
    }
  }
]
EOF
}