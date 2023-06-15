aws_region = "eu-west-2"

vpcs = {
  vpc-01 = {
    cidr                             = "10.0.0.0/16"
    dns_support                      = true
    dns_hostnames                    = true
    assign_generated_ipv6_cidr_block = false
    infra_env                        = "DEV-VPC-01"
  }
  vpc-02 = {
    cidr                             = "192.168.0.0/16"
    dns_support                      = true
    dns_hostnames                    = true
    assign_generated_ipv6_cidr_block = false
    infra_env                        = "DEV-VPC-02"
  }
}