terraform {
  required_version = ">= 1.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.33"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = lookup(var.profile, var.environment)
}

module "accounts" {
  source                       = "./modules/accounts"
  environment                  = var.environment
  owner_email                  = var.owner_email
  sso_admin_group_id           = var.sso_admin_group_id
  sso_admin_permission_set_arn = var.sso_admin_permission_set_arn
}

module "iam" {
  source                  = "./modules/iam"
  infrastructure_provider = local.provider
  state_bucket_name       = local.state_bucket_name
  environment             = var.environment
  region                  = var.aws_region
  created_account_id      = module.accounts.created_account_id
}
