# VPC Module
module "vpc" {
  source = "./modules/vpc"
  
  project_name = var.project_name
  environment  = var.environment
  
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
}

# Security Groups Module
module "security_groups" {
  source = "./modules/security_groups"
  
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
}

# ALB Module
module "alb" {
  source = "./modules/alb"
  
  project_name    = var.project_name
  environment     = var.environment
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnet_ids
  security_groups = [module.security_groups.alb_security_group_id]
}

# Auto Scaling Module
module "autoscaling" {
  source = "./modules/autoscaling"
  
  project_name       = var.project_name
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  public_subnets     = module.vpc.public_subnet_ids
  security_groups    = [module.security_groups.web_security_group_id]
  target_group_arn   = module.alb.target_group_arn
  
  ami_id        = var.ami_id
  instance_type = var.environment == "production" ? "t3.medium" : "t2.micro"
  key_name      = var.key_name
  
  min_size         = var.min_instances
  max_size         = var.max_instances
  desired_capacity = var.desired_instances
}
