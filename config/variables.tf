variable "s3_backend_bucket_region" {
  type        = string                                         # The type of the variable, in this case a string
  default     = "us-east-1"                                    # Default value for the variable
  description = "The region for the Terraform's state backend" # Description of what this variable represents
}
