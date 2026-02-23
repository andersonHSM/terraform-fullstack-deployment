terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.32"
    }
  }



  backend "s3" {
    use_lockfile = true
    encrypt      = true
  }
}
