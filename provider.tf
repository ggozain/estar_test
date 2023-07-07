terraform {
  cloud {
    organization = "your-tf-cloud-organization"
    workspaces {
      name = "your-workspace"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.3.0"
    }
  }

  required_version = "~> 1.4.2"
}

provider "aws" {
  region = var.aws_region
}