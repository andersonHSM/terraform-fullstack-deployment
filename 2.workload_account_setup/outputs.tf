output "terraform_management_role_arn" {
  value = aws_iam_role.management_account_assume_role.arn
}

output "user_pool_id" {
  value = module.cognito.user_pool_id
}

output "user_pool_arn" {
  value = module.cognito.user_pool_arn
}

output "app_client_id" {
  value = module.cognito.app_client_id
}

