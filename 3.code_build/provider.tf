terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.33"
    }
  }
}

provider "aws" {
  assume_role {
    role_arn = var.workload_account_terraform_role_to_assume
  }
}