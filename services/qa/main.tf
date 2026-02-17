terraform {
  required_version = ">= 1.2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.82"
    }
  }
}

provider "aws" {
  region = local.default_region
  assume_role {
    role_arn    = local.s3_management_assume_role
    external_id = "roadmap-provider-aws-assume-role"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "curso-deploy-qa-terraform-example-bucket"
  tags = {
    Name = "Meu Bucket" # Tag the instance with a Name tag for easier identification
  }
}

resource "aws_s3_bucket_versioning" "example-versioning" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}
