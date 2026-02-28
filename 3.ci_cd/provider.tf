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


provider "aws" {
  region  = var.region
  alias   = "qa"
  profile = lookup(var.profile, "qa", "")
}

provider "aws" {
  region  = var.region
  alias   = "prod"
  profile = lookup(var.profile, "prod", "")
}
