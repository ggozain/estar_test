variable "aws_region" {
    type = string
    description = "The desired AWS region to work in"
    default = "eu-west-2"
}

variable "vpc_cidr" {
    type = string
    description = "The CIDR for the VPC"
}


