resource "aws_security_group" "ALB-SG" {
  name                   = var.alb_sg_name
  description            = var.alb_sg_description
  vpc_id                 = var.vpc_id
# Inbound Rules
  # HTTP access from anywhere
  # ingress {
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  # egress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }


# tags = {
#    Name = "ECS LB-SG"
#  }
 }
