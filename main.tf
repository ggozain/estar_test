
module "vpc" {
  source = "./modules/vpc"

  for_each = var.vpcs

  aws_region                       = var.aws_region
  vpc_cidr                         = each.value["cidr"]
  enable_dns_support               = each.value["dns_support"]
  enable_dns_hostnames             = each.value["dns_hostnames"]
  assign_generated_ipv6_cidr_block = each.value["assign_generated_ipv6_cidr_block"]
}







