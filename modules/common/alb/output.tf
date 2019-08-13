output "alb_arn" {
  value = aws_alb.main.arn
}

output "alb_dns_name" {
  value = aws_alb.main.dns_name
}

output "alb_target_group_arn" {
  value = aws_alb_target_group.app.arn
}

output "alb_security_group_id" {
  value = aws_security_group.lb.id
}