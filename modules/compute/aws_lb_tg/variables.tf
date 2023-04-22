variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = null
}

variable "tg_name" {
  type = string
}

variable "tg_type" {
  type = string
}

variable "tg_port" {
  type = number
}

variable "tg_protocol" {
  type = string
}

# variable "tg_enabled" {
#   type = bool
# }

# variable "tg_healthy_threshold" {
#   type = number
# }
variable "tg_interval" {
  type = number
}
variable "tg_matcher" {
  
}
variable "tg_path" {
  type = string

}
# variable "tg_h_port" {
#   type = string
# }
# variable "tg_h_protocol" {
#   type = string
# }
variable "tg_timeout" {
  type = number
}
# variable "tg_unhealthy_threshold" {
#   type = number
# }