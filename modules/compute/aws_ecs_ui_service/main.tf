# resource "aws_ecs_service" "ecs_service" {
#   name            = var.service_name
#   cluster         = var.cluster
#   task_definition = var.task_definition
#   desired_count   = var.desired_count  
#   # launch_type = var.launch_type
#   health_check_grace_period_seconds = var.health_check_grace_period_seconds
  
#   load_balancer {
#     target_group_arn = "${var.alb_target_group_arn}"
#     container_name   = var.container_name
#     container_port   = var.container_port
#   }
  
#   network_configuration {
#   security_groups    = var.security_groups
#   subnets            = var.subnets
#   # assign_public_ip = var.assign_public_ip
  
#   }
#   # lifecycle {
#   #   ignore_changes = [desired_count]
#   # }
#   capacity_provider_strategy {
#     capacity_provider = var.capacity_provider
#     base =  var.service_cp_base
#     weight = var.service_cp_weight
#   }
#   service_connect_configuration {
#     enabled = true
#     namespace = var.namespace
#   }
  
# }



resource "aws_appautoscaling_target" "ecs_target" {
  service_namespace  = "ecs"
  scalable_dimension = "ecs:service:DesiredCount"
  resource_id        = var.resource_id 
  min_capacity       = var.task_min_capacity
  max_capacity       = var.task_max_capacity
  depends_on = [
    aws_ecs_service.ecs_service
  ]
}

resource "aws_appautoscaling_policy" "ecs_policy" {
  name               = "ECS-auto-scaling"
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.predefined_metric_type
    }

    target_value       = var.target_value
    scale_in_cooldown  = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown
  }
}






##############################################################
##                    discovery service                     ##
##############################################################


resource "aws_ecs_service" "ecs_service" {
  name            = var.service_name
  cluster         = var.cluster
  task_definition = var.task_definition
  desired_count   = var.desired_count  
  
  network_configuration {
  security_groups    = var.security_groups
  subnets            = var.subnets
  # assign_public_ip = var.assign_public_ip
  
  }
  capacity_provider_strategy {
    capacity_provider = var.capacity_provider
    base =  var.service_cp_base
    weight = var.service_cp_weight
  }
  service_registries {
    registry_arn      = aws_service_discovery_service.microservice_discovery_service.arn
  }
  # Ignored desired count changes live, permitting schedulers to update this value without terraform reverting
  
  load_balancer {
    target_group_arn = "${var.alb_target_group_arn}"
    container_name   = var.container_name
    container_port   = var.container_port
  }

}

##############################################################
##                    discovery service                     ##
##############################################################
resource "aws_service_discovery_service" "microservice_discovery_service" {

  name = var.service_name
  dns_config {
    namespace_id = "${var.reg_arn}"
    routing_policy = var.routing_policy

    dns_records {
      ttl  = var.ttl
      type = var.record_type
    }

  }

  health_check_custom_config {
    failure_threshold = var.failure_threshold
  }


}