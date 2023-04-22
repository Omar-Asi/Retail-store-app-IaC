variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = null
}

variable "alb_sg_name" {
  description = "Name of security group - not required if create_sg is false"
  type        = string
  default     = null
}

variable "alb_sg_description" {
  description = "Description of security group"
  type        = string
  default     = "Security Group managed by Terraform"
}