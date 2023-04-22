variable "family" {
  description = "Task Definition family name"
  type        = string
  default     = null
}



variable "name" {
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

variable "desired_count" {
  description = ""
  type        = number
  default     = null
}

variable "target_group_arn" {
  description = ""
  type        = string
  default     = null
}

variable "execution_role_arn" {
  type = string
}

variable "task_role_arn" {
  type = string
}

variable "container_definitions" {
  type = string
}
variable "requires_compatibilities" {
  # type = list(string)
}

variable "network_mode" {
  type = string
}
variable "cpu" {
  type = string
}
variable "memory" {
  type = string
}