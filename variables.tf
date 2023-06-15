
variable "aws_region" {
  type        = string
  description = "The AWS region on which to execute the code"
  default     = "eu-west-2"
}

variable "vpcs" {
  type = map(object({
    cidr                             = string
    dns_support                      = bool
    dns_hostnames                    = bool
    assign_generated_ipv6_cidr_block = bool
    infra_env                        = string

  }))

}