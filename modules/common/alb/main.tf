# ALB Security Group: Edit this to restrict access to the application
resource "aws_security_group" "lb" {
  name        = var.alb_security_group_name
  description = var.alb_security_group_description
  vpc_id      = var.vpc_id
//  tags        = var.tags
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_alb" "main" {
  name            = var.alb_name
  subnets         = var.public_subnets
  security_groups = [aws_security_group.lb.id]
  tags            = var.tags
}

resource "aws_alb_target_group" "app" {
  name        = var.alb_target_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  tags        = var.tags

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "my_website_https" {
  load_balancer_arn = aws_alb.main.id
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.aws_acm_certificate_arn
//  tags        = var.tags
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.app.id
  }
}


resource "aws_lb_listener" "my_website_http" {
  load_balancer_arn = aws_alb.main.id
  port              = "80"
  protocol          = "HTTP"
//  tags              = var.tags
  default_action {
    type = "redirect"
    target_group_arn = aws_alb_target_group.app.id

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
      host = "#{host}"
      path = "/#{path}"
      query = "#{query}"
    }
  }
}
