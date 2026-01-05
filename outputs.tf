output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "alb_dns_name" {
  description = "ALB DNS Name"
  value       = module.alb.alb_dns_name
}

output "alb_zone_id" {
  description = "ALB Zone ID"
  value       = module.alb.alb_zone_id
}

output "target_group_arn" {
  description = "Target Group ARN"
  value       = module.alb.target_group_arn
}

output "autoscaling_group_name" {
  description = "Auto Scaling Group Name"
  value       = module.autoscaling.asg_name
}

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = module.vpc.public_subnet_ids
}
