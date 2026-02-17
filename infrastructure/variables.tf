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

variable "sso_admin_username_to_attach_to_account" {
  type        = string
  description = "The SSO Admin username to create and assign for the given accounts"
  nullable    = false
}

variable "sso_admin_display_name_to_attach_to_account" {
  type        = string
  description = "The SSO Admin Display name to create and assign for the given accounts"
  nullable    = false
}

variable "sso_admin_email_to_attach_to_account" {
  type        = string
  description = "The SSO Admin e-mail for the user"
  nullable    = false
}

variable "sso_admin_name_to_attach_to_account" {
  type        = string
  description = "The SSO Admin name for the user"
  nullable    = false
}

variable "sso_admin_family_name_to_attach_to_account" {
  type        = string
  description = "The SSO Admin family name for the user"
  nullable    = false
}
