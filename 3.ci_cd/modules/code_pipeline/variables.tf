
variable "environment" {}
variable "frontend_repository" {}
variable "backend_repository" {}

variable "project_name" {}
variable "region" {}


variable "code_star_connection_arn" {
  default     = ""
  description = "The CodeStar Connection of the AWS Connector for GitHub App installed to your repo"
}

variable "frontend_build_project_name" {}
