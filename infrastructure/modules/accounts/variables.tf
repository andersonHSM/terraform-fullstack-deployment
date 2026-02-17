variable "environment" {
  type        = string
  description = "The environment to create the account for"
}

variable "owner_email" {
  type        = string
  description = "The owner e-mail for the account. Must be unique in AWs"
  nullable    = true
}

variable "sso_admin_user_to_attach_to_account" {
  type        = string
  description = "The IAM Identity Center user to attach to the new account form admin access"
  nullable    = false
}
