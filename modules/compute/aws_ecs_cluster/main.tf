resource "aws_ecs_cluster" "ecs_cluster" {
  
  name = var.cluster_name
  
}

data "template_file" "user_data" {
  template = <<-EOF
#!/bin/bash 
echo ECS_CLUSTER="${var.cluster_name}" >> /etc/ecs/ecs.config;
  EOF
}





resource "aws_launch_template" "ecs_LT" {
  name_prefix   = var.launch_template_name
  image_id      = var.image_id
  instance_type = var.instance_type
   key_name = "MyKey"
  iam_instance_profile {
    arn =var.instance_iam_role
  }
  user_data = "${base64encode(data.template_file.user_data.rendered)}"
}

resource "aws_autoscaling_group" "ecs_asg" {
  name = var.asg_name
  vpc_zone_identifier = var.vpc_zone_identifier
  # desired_capacity   = var.desired_capacity
  max_size           = var.max_size
  min_size           = var.min_size
  default_cooldown = var.default_cooldown
  launch_template {
    id      = aws_launch_template.ecs_LT.id
    version = var.lt_version
  }
}



resource "aws_service_discovery_private_dns_namespace" "namespace" {
  name        = "retailapp.dev"
  description = "aws_service_discovery_private_dns_namespace"
  vpc         = var.vpc_id
}


resource "aws_ecs_capacity_provider" "test" {
  name = var.cp_name

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs_asg.arn
    # managed_termination_protection = "ENABLED"

    managed_scaling {
      # maximum_scaling_step_size = 1000
      # minimum_scaling_step_size = 1


    
      status                    = var.managed_scaling_status
    #   target_capacity           = 10
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "example" {
  cluster_name = aws_ecs_cluster.ecs_cluster.name

  capacity_providers = [aws_ecs_capacity_provider.test.name]

  default_capacity_provider_strategy {
    base              =  var.default_base
    weight            = var.default_weight
    capacity_provider = aws_ecs_capacity_provider.test.name
  }
}







