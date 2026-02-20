variable "current_environment" {
  type        = string
  description = "Current environment to run commands against."
  validation {
    condition     = contains(["qa", "prod"], var.current_environment)
    error_message = "Environment must be qa or prod"
  }
}

variable "owner_email" {
  type        = string
  description = "The owner of the account e-mail."
  nullable    = false
}

variable "sso_admin_group_id" {
  type        = string
  description = "The Admin Group outputted on the bootstrap setup"
}

variable "sso_admin_permission_set_arn" {
  type        = string
  description = "The Admin Permission Set outputted on the bootstrap setup"
}
