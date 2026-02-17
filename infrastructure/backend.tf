terraform {
  backend "s3" {
    region       = "us-east-1"
    bucket       = "roadmap-aws-infrastructure"
    key          = "terraform-infrastructure/state/terraform.tfstate"
    use_lockfile = true
  }
}
