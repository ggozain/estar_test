terraform {
  cloud {
    organization = "gozain-lab"
    workspaces {
      name = "estar_test"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.3.0"
    }
  }

  required_version = "1.4.2"
}

provider "aws" {
  region = var.aws_region
}