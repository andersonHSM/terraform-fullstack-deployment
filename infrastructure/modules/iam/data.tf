data "aws_ssoadmin_instances" "sso_instance" {}

data "aws_iam_policy_document" "allow_terraform_user_to_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = [aws_iam_user.terraform_user.arn]
      type        = "AWS"
    }
  }
}

data "aws_iam_policy" "aws_managed_s3_full_access" {
  arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

data "aws_identitystore_group" "admin_group" {
  identity_store_id = data.aws_ssoadmin_instances.sso_instance.identity_store_ids[0]
  alternate_identifier {
    unique_attribute {
      attribute_path  = ""
      attribute_value = ""
    }
  }
}
