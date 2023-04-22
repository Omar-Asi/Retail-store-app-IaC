resource "aws_lb_target_group" "alb_tg" {
  name        = var.tg_name
  target_type = var.tg_type
  port        = var.tg_port
  protocol    = var.tg_protocol
  vpc_id      = var.vpc_id
  health_check {
  #   enabled = var.tg_enabled
  #   healthy_threshold = var.tg_healthy_threshold
    interval = var.tg_interval
    matcher = var.tg_matcher
    path = var.tg_path
  #   port = var.tg_h_port
  #   protocol = var.tg_h_protocol
    timeout = var.tg_timeout
  #   unhealthy_threshold = var.tg_unhealthy_threshold
  }
}