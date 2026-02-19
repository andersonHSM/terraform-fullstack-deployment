variable "region" {
  description = "AWS region for state bucket"
  type        = string
  default     = "us-east-1"
}

variable "state_bucket_name" {
  description = "Terraform state bucket name (globally unique)"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "shared"
}

variable "admin_username" {
  type        = string
  description = "The username you wanna give to your admin user."
}

variable "admin_display_name" {
  type        = string
  description = "The DisplayName you wanna give to your admin user."
}

variable "admin_primary_email" {
  type        = string
  description = "The PrimaryEmail you wanna give to your admin user."
}

variable "admin_name" {
  type = string
}
variable "admin_family_name" {
  type = string
}

variable "sso_admin_account_id" {
  type = string
}
