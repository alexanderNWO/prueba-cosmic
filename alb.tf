resource "aws_lb_target_group" "TG_Cosmic_Armenta" {
  name     = "TGCosmicArmenta"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_cosmic_armenta_virginia.id
}

resource "aws_lb_target_group_attachment" "TGA_Cosmic_Armenta" {
  target_group_arn = aws_lb_target_group.TG_Cosmic_Armenta.arn
  target_id        = aws_instance.cosmic_armenta_docker_instance.id
  port             = 8080
}

resource "aws_lb" "LB_Cosmic_Armenta" {
  name               = "ALBCosmicArmenta"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_public_instances_cosmic_armenta.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  depends_on = [
    module.acm_request_certificate
  ]

  enable_deletion_protection = false

  tags = {
    Name = "LB - ${local.sufix}"
  }
}

resource "aws_lb_listener" "LBListener_Cosmic_Armenta_HTTP" {
  load_balancer_arn = aws_lb.LB_Cosmic_Armenta.arn
  port              = "80"
  protocol          = "HTTP"
  depends_on = [
    aws_lb_target_group.TG_Cosmic_Armenta
  ]

  default_action {
    type = "redirect"
    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "LBListener_Cosmic_Armenta_HTTPS" {
  load_balancer_arn = aws_lb.LB_Cosmic_Armenta.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = module.acm_request_certificate.arn
  depends_on = [
    aws_lb_target_group.TG_Cosmic_Armenta
  ]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG_Cosmic_Armenta.arn
  }
}