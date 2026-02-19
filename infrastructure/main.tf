terraform {
  required_version = ">= 1.12" # Ensure that the Terraform version is 1.0.0 or higher

  required_providers {
    aws = {
      source  = "hashicorp/aws" # Specify the source of the AWS provider
      version = "~> 6.32"       # Use a version of the AWS provider that is compatible with version
    }
  }
}

provider "aws" {
  region = local.default_region
}

module "accounts" {
  source                                      = "./modules/accounts"
  environment                                 = var.current_environment
  owner_email                                 = var.owner_email
  sso_admin_username_to_attach_to_account     = var.sso_admin_username_to_attach_to_account
  sso_admin_display_name_to_attach_to_account = var.sso_admin_display_name_to_attach_to_account
  sso_admin_email_to_attach_to_account        = var.sso_admin_email_to_attach_to_account
  sso_admin_family_name_to_attach_to_account  = var.sso_admin_family_name_to_attach_to_account
  sso_admin_name_to_attach_to_account         = var.sso_admin_name_to_attach_to_account
}

module "iam" {
  source = "./modules/iam"
}
