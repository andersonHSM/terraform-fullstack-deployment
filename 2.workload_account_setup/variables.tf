variable "management_account_user_arn" {
  type        = string
  description = "The ARN of the user in the management account where state resides"
}

variable "environment" {
  type = string
}

variable "tfstate_region" {
  default = ""
}
variable "tfstate_bucket" {
  default = ""
}
variable "tfstate_key" {
  default = ""
}
variable "tfstate_assume_role" {
  default = ""
}