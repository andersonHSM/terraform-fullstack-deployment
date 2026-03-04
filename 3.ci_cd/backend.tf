terraform {
  backend "s3" {
    region       = var.backend_config.region
    use_lockfile = true
    encrypt      = true
    bucket       = var.backend_config.bucket
    key          = var.backend_config.key
    assume_role = {
      role_arn = var.backend_config.role_arn
    }
    profile = var.backend_config.profile
  }
}
