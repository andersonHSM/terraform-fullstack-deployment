terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 6.33"
      configuration_aliases = [aws.management, aws.qa, aws.prod]
    }
  }
}

