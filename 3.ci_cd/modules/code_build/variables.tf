
variable "environment" {}
variable "repository_name" {}
variable "repository_url" {}
variable "repo_code_star_connection_arn" {}
variable "artifacts_bucket_name" {}
variable "artifacts_bucket_arn" {}
variable "aws_account_id" {}
variable "aws_region" {}
variable "encryption_key_arn" {}
variable "ecr_repository_name" {
  default = ""
}