variable "ex_role_name" {
  
}
variable "ex_policy_name" {
  
}
variable "ex_role_assume_role_policy_path" {
  type = string
}
variable "ex_role_policy_path" {
  type = string
}
variable "task_role_name" {
  
}
variable "task_role_policy_name" {
  
}
variable "task_role_assume_role_policy_path" {
  type = string
}
variable "task_role_policy_path" {
  type = string
}






variable "tg_name" {
  
}
variable "tg_type" {
  
}
variable "tg_port" {
  
}
variable "tg_protocol" {
  
}
# variable "tg_enabled" {
  
# }
# variable "tg_healthy_threshold" {
  
# }
variable "tg_interval" {
  
}
variable "tg_matcher" {
  
}
variable "tg_path" {
  
}
# variable "tg_h_port" {
  
# }
# variable "tg_h_protocol" {
  
# }
variable "tg_timeout" {
  
}
# variable "tg_unhealthy_threshold" {
  
# }







variable "ls_port" {
  
}
variable "ls_protocol" {
  
}
variable "ls_type" {
  
}






variable "alb_name" {
  
}
variable "alb_internal" {
  
}
variable "load_balancer_type" {
  
}




# variable "capacity_provider" {
  
# }
variable "health_check_grace_period_seconds" {
  
}

variable "desired_count" {
  
}

#####################################################
variable "ui_service_name" {
  
}
variable "ui_container_name" {
  
}
variable "ui_container_port" {
  
}

variable "ui_container_definitions_path" {
  type = string
}

variable "ui_family" {
  
}
####################################


variable "cart_service_name" {
  
}
# variable "cart_container_name" {
  
# }
# variable "cart_container_port" {
  
# }

variable "cart_container_definitions_path" {
  type = string
}

variable "cart_family" {
  
}
####################################

variable "cart_db_service_name" {
  
}
# variable "cart_db_container_name" {
  
# }
# variable "cart_db_container_port" {
  
# }

variable "cart_db_container_definitions_path" {
  type = string
}

variable "cart_db_family" {
  
}
####################################
variable "redis_service_name" {
  
}
# variable "redis_container_name" {
  
# }
# variable "redis_container_port" {
  
# }

variable "redis_container_definitions_path" {
  type = string
}

variable "redis_family" {
  
}
####################################


variable "rabbitmq_service_name" {
  
}
# variable "rabbitmq_container_name" {
  
# }
# variable "rabbitmq_container_port" {
  
# }

variable "rabbitmq_container_definitions_path" {
  type = string
}

variable "rabbitmq_family" {
  
}
####################################


variable "checkout_service_name" {
  
}
# variable "checkout_container_name" {
  
# }
# variable "checkout_container_port" {
  
# }

variable "checkout_container_definitions_path" {
  type = string
}

variable "checkout_family" {
  
}
####################################


variable "orders_service_name" {
  
}
# variable "orders_container_name" {
  
# }
# variable "orders_container_port" {
  
# }

variable "orders_container_definitions_path" {
  type = string
}

variable "orders_family" {
  
}
####################################

variable "orders_db_service_name" {
  
}
# variable "orders_db_container_name" {
  
# }
# variable "orders_db_container_port" {
  
# }

variable "orders_db_container_definitions_path" {
  type = string
}

variable "orders_db_family" {
  
}
####################################

variable "catalog_service_name" {
  
}
# variable "catalog_container_name" {
  
# }
# variable "catalog_container_port" {
  
# }

variable "catalog_container_definitions_path" {
  type = string
}

variable "catalog_family" {
  
}
####################################

variable "catalog_db_service_name" {
  
}
# variable "catalog_db_container_name" {
  
# }
# variable "catalog_db_container_port" {
  
# }

variable "catalog_db_container_definitions_path" {
  type = string
}

variable "catalog_db_family" {
  
}
####################################

variable "assets_service_name" {
  
}
# variable "assets_container_name" {
  
# }
# variable "assets_container_port" {
  
# }

variable "assets_container_definitions_path" {
  type = string
}

variable "assets_family" {
  
}
####################################


# variable "assign_public_ip" {
  
# }
# variable "user_data" {
  
# }





variable "cluster_name" {
  
}

variable "launch_template_name" {
  
}
variable "image_id" {
  
}
variable "instance_type" {
  
}
# variable "desired_capacity" {
  
# }
variable "max_size" {
  
}
variable "min_size" {
  
}

variable "default_cooldown" {
  
}

variable "managed_scaling_status" {
  
}

variable "default_base" {
  
}
variable "default_weight" {
  
}
variable "service_cp_base" {
  
}
variable "service_cp_weight" {
  
}


variable "requires_compatibilities" {
  
}
variable "network_mode" {
  
}
variable "cpu" {
  
}
variable "memory" {
  
}

variable "availability_zone" {
  
}

# variable "vpc_zone_identifier" {
  
# }
variable "public_subnet_cidrs" {
  
}
variable "public_subnet_name" {
  
}

variable "private_subnet_name" {
  
}
variable "vpc_name" {
  
}
variable "public_rt_cidr_block" {
  
}
variable "private_subnet_cidrs" {
  
}
variable "private_rt_cidr_block" {
  
}
variable "igw_name" {
  
}
variable "public_rt_name" {
  
}
variable "private_rt_name" {
  
}
variable "eip_name" {
  
}
variable "nat_name" {
  
}
variable "vpc_cidr_block" {
  
}
variable "vpc_or_not" {
  
}
variable "db_subnet_group_name" {
  
}
variable "ec_subnet_group_name" {
  
}
# variable "tags" {
  
# }


variable "ui_ecr_repository_name" {
  
}

variable "catalog_ecr_repository_name" {
  
}
variable "cart_ecr_repository_name" {
  
}
variable "orders_ecr_repository_name" {
  
}
variable "assets_ecr_repository_name" {
  
}
variable "checkout_ecr_repository_name" {
  
}
variable "rabbitmq_ecr_repository_name" {
  
}




variable "orders_db_name" {
  
}

variable "orders_db_identifier" {
  
}

variable "allocated_storage" {
  
}

variable "engine" {
  
}

variable "engine_version" {
  
}

variable "instance_class" {
  
}

variable "catalog_db_name" {
  
}

variable "username" {
  
}

variable "password" {
  
}

variable "parameter_group_name" {
  
}

variable "catalog_db_identifier" {
  
}

variable "skip_final_snapshot" {
  
}














variable "sg_rule_type1" {
  
}
# variable "security_group_id1" {
  
# }
variable "from1" {
  
}
variable "to1" {
  
}
variable "sg_protocol1" {
  
}
variable "sg_cidr1" {
  
}

variable "from3" {
  
}

variable "to3" {
  
}

variable "sg_cidr3" {
  
}


variable "sg_rule_type2" {
  
}
# variable "security_group_id2" {
  
# }
variable "from2" {
  
}
variable "to2" {
  
}
variable "sg_protocol2" {
  
}
variable "sg_cidr2" {
  
}
variable "lt_version" {
  
}
variable "asg_name" {
  
}
# variable "asg_policy_name" {
  
# }
# variable "asg_policy_type" {
  
# }
variable "predefined_metric_type" {
  
}
# variable "target_value" {
  
# }
variable "cp_name" {
  
}
variable "instance_iam_role" {
  
}
variable "target_value" {
  
}
variable "scale_in_cooldown" {
  
}
variable "scale_out_cooldown" {
  
}

variable "task_min_capacity" {
  
}
variable "task_max_capacity" {
  
}
