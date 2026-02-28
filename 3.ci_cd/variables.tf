variable "valid_environments" {
  default = ["tools", "qa", "prod"]
}

variable "workload_account_terraform_role_to_assume" {
  type        = string
  description = "The role in the destination account to assume and create resources"
}

variable "environment" {
  type        = string
  description = "The profile related to the account to work with. Values in (tools, qa, prod)"
  validation {
    condition     = contains(var.valid_environments, var.environment)
    error_message = "Provide a valid value for your environment"
  }
}

variable "profile" {
  type     = map(string)
  nullable = false
  default = {
    qa    = "qa_profile"
    prod  = "prod_profile"
    tools = "tools_profile"
  }
}

variable "frontend_repository" {}
variable "frontend_repository_url" {}
variable "backend_repository" {}

variable "project_name" {}
variable "region" {}
variable "management_account_id" {}
