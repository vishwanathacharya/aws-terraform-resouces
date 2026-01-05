# Bastion Host Module
module "bastion" {
  source = "./modules/bastion"
  
  project_name    = var.project_name
  environment     = var.environment
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnet_ids
  security_groups = [module.security_groups.bastion_security_group_id]
  
  ami_id        = var.ami_id
  instance_type = "t2.micro"
  key_name      = var.key_name
}
