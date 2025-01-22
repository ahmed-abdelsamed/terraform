locals {
region = "us-east-1"
project_name = "UAT"
vpc_cidr = "10.0.0.0/16"
public_subnet_az1_cidr = "10.0.0.0/24"
public_subnet_az2_cidr = "10.0.1.0/24"
private_app_subnet_az1_cidr = "10.0.2.0/24"
private_app_subnet_az2_cidr = "10.0.3.0/24"
private_data_subnet_az1_cidr = "10.0.4.0/24"
private_data_subnet_az2_cidr = "10.0.5.0/24"
# Provider
AWS_ACCESS_KEY_ID = ""
AWS_SECRET_ACCESS_KEY = ""
#AWS_SESSION_TOKEN = ""
#AWS_REGION = ""
domain_name = "linkdev.com"   # register on route 53
alternative_name = "*.linkdev.com"
}
