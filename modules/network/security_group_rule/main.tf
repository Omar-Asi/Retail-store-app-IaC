resource "aws_security_group_rule" "allow" {
type= var.sg_rule_type
security_group_id = var.security_group_id
from_port = var.from
to_port = var.to
protocol = var.sg_protocol
cidr_blocks = var.sg_cidr
}

variable "sg_rule_type" {
  
}
variable "security_group_id" {
  
}
variable "from" {
  
}
variable "to" {
  
}
variable "sg_protocol" {
  
}
variable "sg_cidr" {
  
}