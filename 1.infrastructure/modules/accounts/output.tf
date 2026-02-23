output "created_account_id" {
  value = aws_organizations_account.environment_account.id
}
output "created_account_arn" {
  value = aws_organizations_account.environment_account.arn
}

output "created_account_environment" {
  value = var.environment
}
