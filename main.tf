
module "vpc" {
  source                           = "./modules/vpc"
  vpc_cidr                         = "10.0.0.0/16"
  aws_region                       = var.aws_region
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false
}







