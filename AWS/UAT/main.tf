# Create vpc
module "vpc" {
  source                       = "../modules/aws-vpc"
  region                       =  local.region
  project_name                 = local.project_name
  vpc_cidr                     = local.vpc_cidr
  public_subnet_az1_cidr       = local.public_subnet_az1_cidr 
  public_subnet_az2_cidr       =  local.public_subnet_az2_cidr
  private_app_subnet_az1_cidr  =  local.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr  =  local.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr =  local.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = local.private_data_subnet_az2_cidr
}


# create nat gateways 
module "nat_gateway" {
  source                       = "../modules/aws-nat_gw"
  public_subnet_az1_id         = module.vpc.public_subnet_az1_id
  internet_gateway             = module.vpc.internet_gateway
  public_subnet_az2_id         = module.vpc.public_subnet_az2_id
  vpc_id                       = module.vpc.vpc_id
  private_app_subnet_az1_id    = module.vpc.private_app_subnet_az1_id
  private_data_subnet_az1_id   = module.vpc.private_data_subnet_az1_id
  private_app_subnet_az2_id    = module.vpc.private_app_subnet_az2_id
  private_data_subnet_az2_id   = module.vpc.private_data_subnet_az2_id
}

# create security groups
module "security_group" {
  source = "../modules/aws-security-group"
  vpc_id = module.vpc.vpc_id
}

## ecs tasks execution role
module "ecs_tasks_execution_role" {
  source                = "../modules/aws-ecs-tasks-execution-role"
  project_name          = module.vpc.project_name
}

## aws acm
module "acm" {
  source           = "../modules/aws-acm"
  domain_name      = local.domain_name
  alternative_name = local.alternative_name
}

# Application LB
module "application_load_balancer" {
  source = "../modules/aws-elb"
  project_name = module.vpc.project_name
  alb_security_group_id = module.security_group.alb_security_group_id
  public_subnet_az1_id = module.vpc.public_subnet_az1_id
  public_subnet_az2_id = module.vpc.public_subnet_az2_id
  vpc_id               = module.vpc.vpc_id
  certificate_arn      = module.acm.certificate_arn
}