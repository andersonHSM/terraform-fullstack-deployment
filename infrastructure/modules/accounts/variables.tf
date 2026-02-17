variable "environment" {
  type        = string
  description = "The environment to create the account for"
}

variable "owner_email" {
  type        = string
  description = "The owner e-mail for the account. Must be unique in AWs"
  nullable    = true
}

variable "sso_admin_username_to_attach_to_account" {
  type        = string
  description = "The IAM Identity Center user to attach to the new account form admin access"
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
