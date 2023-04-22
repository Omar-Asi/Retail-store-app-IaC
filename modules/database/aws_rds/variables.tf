variable "db_subnet_group_name" {
  
  type        = string
  default = null
  
}

variable "allocated_storage" {
  
  type        = number
  default = 10
  
}

variable "vpc_security_group_ids" {
  
  type        = list(string)
  default = []
  
}

variable "engine" {
  
  type        = string
  default = null
  
}

variable "engine_version" {
  
  type        = string
  default = null
  
}

variable "instance_class" {
  
  type        = string
  default = null
  
}


variable "db_name" {
  
  type        = string
  default = null
  
}


variable "username" {
  
  type        = string
  default = null
  
}

variable "password" {
  
  type        = string
  default = null
  
}

variable "parameter_group_name" {
  
  type        = string
  default = null
  
}

variable "identifier" {
  
  type        = string
  default = null
  
}

variable "skip_final_snapshot" {
  
  type        = bool
  default = false
  
}