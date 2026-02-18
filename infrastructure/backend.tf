terraform {
  backend "s3" {
    region       = "us-east-1"
    bucket       = "curso-deployment-alura-state-2026"
    key          = "infrastructure/terraform.tfstate"
    use_lockfile = true
    encrypt      = true
  }
}
