
variable "s3_management_assume_role" {
  type        = string
  default     = "arn:aws:iam::943772253966:role/terraform-roadmap-aws-assume-role"
  description = "The role in QA account that allows my user credentials to take action in a different account"
}

variable "s3_backend_bucket_region" {
  type        = string                                         # The type of the variable, in this case a string
  default     = "us-east-1"                                    # Default value for the variable
  description = "The region for the Terraform's state backend" # Description of what this variable represents
}
