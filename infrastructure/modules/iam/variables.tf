variable "infrastructure_provider" {
  type        = string
  description = "The provider of the given resource"
  default     = "Terraform"
}

variable "region" {
  description = "AWS region for state bucket"
  type        = string
  default     = "us-east-1"
}

variable "state_bucket_name" {
  description = "Terraform state bucket name (globally unique)"
  type        = string
  nullable    = true
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "shared"
}

variable "created_account_arn" {
  description = "The workload Account created"
  type        = string
}
