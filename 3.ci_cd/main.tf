module "code_build" {
  source                        = "./modules/code_build"
  environment                   = var.environment
  backend_repository            = var.backend_repository
  frontend_repository           = var.frontend_repository
  repo_code_star_connection_arn = module.code_pipeline.repo_code_star_connection_arn
  artifacts_bucket_name         = module.code_pipeline.artifacts_bucket_name
  artifacts_bucket_arn          = module.code_pipeline.artifacts_bucket_arn
  frontend_repository_url       = var.frontend_repository_url

}

module "code_pipeline" {
  source                      = "./modules/code_pipeline"
  backend_repository          = var.backend_repository
  frontend_repository         = var.frontend_repository
  project_name                = var.project_name
  region                      = var.region
  environment                 = var.environment
  frontend_build_project_name = module.code_build.frontend_build_project_name
}
