variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = null
}

variable "subnets" {
  description = "ID subnets"

}


variable "security_groups" {
  description = "ID security groups"
  type        = list(string)
  default     = null
}

variable "alb_name" {
  description = "lb name"
  type        = string
  default     = null
}
variable "alb_internal" {
  type = bool
}

variable "load_balancer_type" {
  type = string
}
