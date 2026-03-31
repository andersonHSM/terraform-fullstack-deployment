variable "environment" {
  type        = string
  description = "The current environment (qa or prod)"
}

variable "owner_email" {
  type        = string
  description = "Owner email for account setup"
}

variable "sso_admin_group_id" {
  type        = string
  description = "The SSO admin group ID"
}

variable "sso_admin_permission_set_arn" {
  type        = string
  description = "The SSO admin permission set ARN"
}

variable "aws_region" {
  type        = string
  description = "The AWS region"
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
