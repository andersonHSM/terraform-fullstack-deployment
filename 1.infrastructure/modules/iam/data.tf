terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.33"
    }
  }
}
data "aws_caller_identity" "caller_identity" {}

data "aws_s3_bucket" "state_bucket" {
  bucket = var.state_bucket_name
  region = var.region
}

data "aws_iam_policy_document" "terraform_state_object_management" {
  statement {
    sid = "1"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "${data.aws_s3_bucket.state_bucket.arn}/${var.environment}/*"
    ]
  }
  statement {
    sid = "3"

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      data.aws_s3_bucket.state_bucket.arn,
    ]
  }

  statement {
    sid       = "2"
    effect    = "Allow"
    actions   = ["s3:ListAllMyBuckets"]
    resources = ["*"]
  }

}

data "aws_iam_policy_document" "cross_account_assume_role" {
  statement {
    sid = "1"

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      identifiers = [
        aws_iam_user.terraform.arn,
        data.aws_caller_identity.caller_identity.arn,
        var.created_account_id
      ]
      type = "AWS"
    }
    effect = "Allow"
  }
}
