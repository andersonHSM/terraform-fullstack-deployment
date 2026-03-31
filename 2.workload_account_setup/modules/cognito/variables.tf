variable "user_pool_name" {
  type        = string
  description = "The name of the Cognito User Pool"
}

variable "environment" {
  type        = string
  description = "The environment for the Cognito resource"
}

variable "app_client_name" {
  type        = string
  description = "The name of the Cognito App Client"
}
