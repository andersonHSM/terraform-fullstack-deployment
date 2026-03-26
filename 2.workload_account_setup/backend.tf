terraform {
  backend "s3" {
    use_lockfile = true
    encrypt      = true
    region       = var.tfstate_region
    bucket       = var.tfstate_bucket
    key          = var.tfstate_key
    assume_role  = var.tfstate_assume_role
  }
}