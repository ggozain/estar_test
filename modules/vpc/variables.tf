variable "aws_region" {
    type = string
    description = "The desired AWS region to work in"
    default = "eu-west-2"
}

variable "vpc_cidr" {
    type = string
    description = "The CIDR for the VPC"
}

variable "enable_dns_support" {
    type = bool
    description = "Enables or disable DNS support"
    default = false
}

variable "enable_dns_hostnames" {
    type = bool
    description = "Enables or disable DNS hostnames"
    default = false
}

variable "assign_generated_ipv6_cidr_block" {
    type = bool
    description = "Enables or disable module to assign generated ipv6 cidr block"
    default = false
}


