variable "vpc_id" {
  description = "VPC ID to create cluster in"
}

variable "vpc_subnets" {
  description = "List of VPC subnets to put instances in"
  # default     = []
}

variable "cluster_name" {
  description = "VPC ID to create cluster in"
}
variable "managed_scaling_status" {
  
}

variable "default_base" {
  
}
variable "default_weight" {
  
}
variable "vpc_zone_identifier" {
  
}

variable "lt_version" {
  
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

variable "asg_name" {
  
}
# variable "asg_policy_name" {
  
# }
# variable "asg_policy_type" {
  
# }
# variable "predefined_metric_type" {
  
# }
# variable "target_value" {
#   type = number
# }
variable "cp_name" {
  
}
variable "instance_iam_role" {
  
}