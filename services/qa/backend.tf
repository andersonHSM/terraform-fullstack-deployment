terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "curso-deploy-qa-infrastructure"
    key    = "terraform-management/state/terraform.tfstate"
    assume_role = {
      role_arn    = "arn:aws:iam::943772253966:role/terraform-roadmap-aws-assume-role"
      external_id = "roadmap-aws-assume-role"
    }
    use_lockfile = true
  }
}
