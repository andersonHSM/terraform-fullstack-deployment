variable "aws_account_id" {
  type        = string
  description = "The AWS Organization account created by the 'iam_identity_center' module."
}

variable "infrastructure_provider" {
  type        = string
  description = "The provider of the given resource"
  default     = "Terraform"
}
