variable "management_account_user_arn" {
  type        = string
  description = "The ARN of the user in the management account where state resides"
}

variable "environment" {
  type = string
}

# variable "workload_account_terraform_role_to_assume" {
#   type        = string
#   description = "The role created on the workload account to assume"
# }
