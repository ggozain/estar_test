# Simple AWS VPC setup using Terraform

This Terraform project is designed to be run on Terraform Cloud. Code will create one or more VPCs (Depending on variables passed on to it). For each VPC it will create 2 subnets, private and public, required NAT Gateways, Internet gateway and required route tables with its associations.

Should you wish to run the code locally, edits are required on the provider.tf file to accommodate this. 

## Prerequisites

Before running this code on Terraform Cloud, please ensure that you have completed the following steps:

1. Set up a Terraform Cloud account and workspace.
2. Configure the Terraform Cloud workspace to have access to your AWS tenant.

## Getting Started

To get started with this project, follow these steps:

1. Clone this repository to your your preferred version control system.

2. Create a new workspace in Terrafrom Cloud using the Version Control Workflow. 

3. Edit the `provider.tf` file to reflect your Terraform Cloud instance and workspace. Update the `organization` and workspace `name` values to match your Terraform Cloud configuration. For example:

   ```hcl
   terraform {
     cloud {
        organization = "your-organization"
        workspaces {
            name = "your workspace"
        }
     }
   }

4. Configure the TF Cloud Workspace to have access to your AWS tenant. Ensure that the necessary AWS credentials and access permissions are set up in your Terraform Cloud workspace. Ideally you would have configured TF Cloud as OIDC in your AWS tenant. (see https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials/aws-configuration)


## Applying the code

The variables should be passed as a separate file. Included in this project you will find an example variables file "Dev.auto.tfvars". 

As the code is to be run on TF Cloud, you should configure these variables using the method of your choice on your TF Cloud workspace. For sake of this test, I have formated the file as auto.tfvars so that TF Cloud can automatically pick the variables out without any further configurations of variables.

Note that best practice when running code from TF Cloud is that variables are to be kept separate from code and appplied using TF Clouds workspace variables/sensitive variables. 


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.6.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.elastic_ip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assign_generated_ipv6_cidr_block"></a> [assign\_generated\_ipv6\_cidr\_block](#input\_assign\_generated\_ipv6\_cidr\_block) | Enables or disable module to assign generated ipv6 cidr block | `bool` | `false` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | Enables or disable DNS hostnames | `bool` | `false` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Enables or disable DNS support | `bool` | `false` | no |
| <a name="input_infra_env"></a> [infra\_env](#input\_infra\_env) | Used for naming the infrasctructure for tagging | `string` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIDR for the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
