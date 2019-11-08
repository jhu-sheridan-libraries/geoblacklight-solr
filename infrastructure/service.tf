resource "aws_ecs_service" "geoblacklight" {
  name = "geoblacklight_solr"
  cluster = "${aws_ecs_cluster.test-ecs-cluster.id}"
  task_definition = "${aws_ecs_task_definition.geoblacklight_solr.arn}"

  desired_count = 1

  deployment_maximum_percent = 100
  deployment_minimum_healthy_percent = 0

    load_balancer {
      target_group_arn  = "${aws_alb_target_group.ecs-target-group.arn}"
      container_port    = 8983
      container_name    = "solr"
  }
}
