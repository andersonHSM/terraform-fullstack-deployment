terraform {
  backend "s3" {
    use_lockfile = true
    encrypt      = true
    region       = var.backend_config.region
    bucket       = var.backend_config.bucket
    key          = var.backend_config.key
    assume_role = {
      role_arn = var.backend_config.role_arn
    }
    profile = var.backend_config.profile
  }
}
