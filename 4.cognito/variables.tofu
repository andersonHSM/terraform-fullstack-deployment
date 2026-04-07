variable "backend_config" {
  type = map(string)
  default = {
    bucket  = "curso-deploy-fullstack-state-2026"
    key     = "qa/auth/terraform.tfstate"
    profile = "anderson_admin_roadmap"
    region  = "us-east-1"
  }

}

variable "user_pool_name" {
  type        = string
  description = "The name of the Cognito User Pool"
}

variable "environment" {
  type        = string
  description = "The environment for the Cognito resource"
}

variable "app_client_name" {
  type        = string
  description = "The name of the Cognito App Client"
}

variable "workload_account_role_to_assume" {
  default = "The role in the workload account to allow the current user on management account to perform resource management"
}