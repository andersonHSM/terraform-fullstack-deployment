terraform {
  backend "s3" {
    region = var.s3_backend_bucket_region
    bucket = "infrastructure"
    key = ""
    organization = "curso-alura-qa"
    assume_role = {
      role_arn = "arn:aws:iam::566946614098:role/terraform-management-assume-role"
    }
  }
}