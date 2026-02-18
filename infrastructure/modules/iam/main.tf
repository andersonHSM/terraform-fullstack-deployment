resource "aws_iam_user" "terraform_user" {
  name          = "terraform_user"
  path          = "/system/"
  force_destroy = true
  tags = {
    "providedBy" = var.infrastructure_provider
  }

}

resource "aws_iam_role" "terraform_assume_role_role" {
  name               = "terraform_assume_role_role"
  assume_role_policy = data.aws_iam_policy_document.allow_terraform_user_to_assume_role_policy.json
}

resource "aws_iam_role_policy" "assign_assume_role_policy_to" {
  name   = "terraform_user_s3_full_access"
  role   = aws_iam_role.terraform_assume_role_role.name
  policy = data.aws_iam_policy.s3_full_access.policy

}
