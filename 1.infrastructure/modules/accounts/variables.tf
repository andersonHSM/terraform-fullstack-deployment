variable "environment" {
  type        = string
  description = "The environment to create the account for"
}

variable "owner_email" {
  type        = string
  description = "The owner e-mail for the account. Must be unique in AWs"
  nullable    = true
}


variable "sso_admin_group_id" {
  type        = string
  description = "The Admin Group outputted on the bootstrap setup"
}

variable "sso_admin_permission_set_arn" {
  type        = string
  description = "The Admin Permission Set outputted on the bootstrap setup"
}
