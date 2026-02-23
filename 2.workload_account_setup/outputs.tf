output "terraform_management_role_arn" {
  value = aws_iam_role.management_account_assume_role.arn
}
