module "frontend_build" {
  source                        = "./modules/code_build"
  environment                   = var.environment
  repository_name               = var.frontend_repository
  repo_code_star_connection_arn = module.code_pipeline.repo_code_star_connection_arn
  artifacts_bucket_name         = module.code_pipeline.artifacts_bucket_name
  artifacts_bucket_arn          = module.code_pipeline.artifacts_bucket_arn
  repository_url                = var.frontend_repository_url
  aws_account_id                = var.aws_account_id
  aws_region                    = var.aws_region
}

moved {
  from = module.code_build
  to   = module.frontend_build
}

module "code_pipeline" {
  source                      = "./modules/code_pipeline"
  backend_repository          = var.backend_repository
  frontend_repository         = var.frontend_repository
  project_name                = var.project_name
  region                      = var.aws_region
  environment                 = var.environment
  frontend_build_project_name = module.frontend_build.frontend_build_project_name
}

module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
}
