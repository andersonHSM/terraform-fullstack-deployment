terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.33"
    }
  }
}



provider "aws" {
  region  = var.region
  profile = lookup(var.profile, var.environment, "")
  alias   = "management"
}
