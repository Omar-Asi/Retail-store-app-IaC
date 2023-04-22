resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = var.alb_internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnets

}



