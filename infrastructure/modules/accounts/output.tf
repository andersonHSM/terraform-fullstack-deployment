output "created_account_id" {
  value = aws_organizations_account.environment_account.id
}

output "created_account_environment" {
  value = var.environment
}
