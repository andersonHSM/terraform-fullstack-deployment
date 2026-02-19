terraform {
  backend "s3" {
    region       = local.default_region
    bucket       = local.state_bucket
    use_lockfile = true
    encrypt      = true
  }
}
