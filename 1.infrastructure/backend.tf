terraform {
  backend "s3" {
    use_lockfile = true
    encrypt      = true
    region       = var.backend_config.region
    bucket       = var.backend_config.bucket
    key          = var.backend_config.key
    profile      = var.backend_config.profile
  }
}
