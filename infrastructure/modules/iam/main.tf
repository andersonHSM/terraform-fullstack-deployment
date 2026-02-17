# resource "aws_iam_role" "terraform_s3_full_access_role" {
#   name               = "terraform-s3-full-access-role"
#   assume_role_policy = data.aws_iam_policy_document.allow_terraform_assume_role_policy.json
# }
#
# resource "aws_iam_policy" "allow_terraform_assume_role_policy" {
#   policy = data.aws_iam_policy_document.allow_terraform_assume_role_policy.json
# }
#
# resource "aws_iam_policy_attachment" "assign_assume_role_policy_to_terraform_user" {
#   name       = "assign_assume_role_policy_to_terraform_user"
#   policy_arn = aws_iam_policy.allow_terraform_assume_role_policy.arn
#   roles = [aws_iam_role.terraform_s3_full_access_role.arn]
# }
#
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
