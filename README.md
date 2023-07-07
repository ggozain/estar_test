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

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 5.3.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region on which to execute the code | `string` | `"eu-west-2"` | no |
| <a name="input_vpcs"></a> [vpcs](#input\_vpcs) | n/a | <pre>map(object({<br>    cidr                             = string<br>    dns_support                      = bool<br>    dns_hostnames                    = bool<br>    assign_generated_ipv6_cidr_block = bool<br>    infra_env                        = string<br><br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
