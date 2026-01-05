output "alb_security_group_id" {
  description = "ALB Security Group ID"
  value       = aws_security_group.alb.id
}

output "web_security_group_id" {
  description = "Web Security Group ID"
  value       = aws_security_group.web.id
}
