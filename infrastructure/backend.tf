terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.32"
    }
  }
  backend "s3" {
    region       = "us-east-1"
    bucket       = "roadmap-aws-infrastructure"
    key          = "terraform-infrastructure/state/terraform.tfstate"
    use_lockfile = true
  }
}
