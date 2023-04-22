resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = var.load_balancer_arn
  port = var.ls_port
  protocol = var.ls_protocol
  default_action {
    type = var.ls_type
    target_group_arn = var.target_group_arn
  }
}