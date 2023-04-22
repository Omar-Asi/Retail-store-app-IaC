variable "vpc" {
  description = ""
  type        = string
  default     = null
}

variable "lb_subnets" {
  description = ""
  type        = list(string)
  default     = null
}

variable "container_name" {
  description = ""
  type        = string
  default     = null
}

variable "service_name" {
  description = ""
  type        = string
  default     = null
}

variable "cluster" {
  description = ""
  type        = string
  default     = null
}

variable "task_definition" {
  description = ""
  type        = string
  default     = null
}

variable "container_port" {
  description = ""
  type        = number
  default     = 80
}

variable "alb_target_group_arn" {
  description = ""
  type        = string
  default     = null
}

variable "desired_count" {
  description = ""
  type        = number
  default     = 1
}

variable "subnets" {}
# variable "assign_public_ip" {
#   type = bool
# }
variable "security_groups" {
  type = list(string)
}

variable "capacity_provider" {
  type = string
}

variable "health_check_grace_period_seconds" {
  type = number
}
variable "resource_id" {}
variable "predefined_metric_type" {}
variable "target_value" {}
variable "scale_in_cooldown" {}
variable "scale_out_cooldown" {}
variable "task_min_capacity" {}
variable "task_max_capacity" {}
variable "service_cp_base" {}
variable "service_cp_weight" {}
variable "namespace" {}
variable "reg_arn" {}
variable "record_type" {
  default = "A"
}
variable "ttl" {
  default = 60
}
variable "failure_threshold" {
  default = 1
}
variable "routing_policy" {
  default = "MULTIVALUE"
}