variable "management_account_user_arn" {
  type        = string
  description = "The ARN of the user in the management account where state resides"
}

variable "environment" {
  type        = string
  description = "The environment for the workload account setup"
}

variable "user_pool_name" {
  type        = string
  description = "The name of the Cognito User Pool"
  default     = "psi-center-user-pool"
}

variable "app_client_name" {
  type        = string
  description = "The name of the Cognito App Client"
  default     = "psi-center-app-client"
}

variable "aws_region" {
  type        = string
  description = "The AWS region to deploy to"
  default     = "us-east-1"
}

variable "profile" {
  type     = map(string)
  nullable = false
  default = {
    qa         = "anderson_admin_roadmap"
    prod       = "anderson_admin_roadmap"
    management = "anderson_admin_roadmap"
  }
}

variable "backend_config" {
  type        = map(string)
  description = "The configuration for the backend state"
}
