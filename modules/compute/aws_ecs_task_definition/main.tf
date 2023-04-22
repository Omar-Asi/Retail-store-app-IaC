resource "aws_ecs_task_definition" "ecs_task_definition" {
  family = var.family
  requires_compatibilities = var.requires_compatibilities
  network_mode             = var.network_mode
  cpu = var.cpu
  memory = var.memory
  execution_role_arn = var.execution_role_arn
  task_role_arn = var.task_role_arn
  container_definitions = var.container_definitions


}