output "launch_template_id" {
  description = "Launch Template ID"
  value       = aws_launch_template.main.id
}

output "asg_name" {
  description = "Auto Scaling Group Name"
  value       = aws_autoscaling_group.main.name
}

output "asg_arn" {
  description = "Auto Scaling Group ARN"
  value       = aws_autoscaling_group.main.arn
}
