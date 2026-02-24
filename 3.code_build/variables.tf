variable "workload_account_terraform_role_to_assume" {
  type        = string
  description = "The role in the destination account to assume and create resources"
}

variable "environment" {
  type = string
}
