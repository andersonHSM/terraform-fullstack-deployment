data "aws_ssoadmin_instances" "instance" {}

data "aws_s3_bucket" "state_bucket" {
  bucket = var.state_bucket_name
  region = var.region
}

data "aws_iam_policy_document" "terraform_state_object_management" {
  statement {
    sid = "1"

    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      data.aws_s3_bucket.state_bucket.arn
    ]
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
        aws_iam_user.terraform.arn
      ]
      type = "AWS"
    }
    effect = "Allow"
  }
}
