terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 6.32"
      configuration_aliases = [aws.root]
    }
  }
}

