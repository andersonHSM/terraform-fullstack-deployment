module "frontend_build" {
  source                        = "./modules/code_build"
  environment                   = var.environment
  repository_name               = var.frontend_repository
  repo_code_star_connection_arn = module.frontend_pipeline.repo_code_star_connection_arn
  artifacts_bucket_name         = module.frontend_pipeline.artifacts_bucket_name
  artifacts_bucket_arn          = module.frontend_pipeline.artifacts_bucket_arn
  repository_url                = var.frontend_repository_url
  aws_account_id                = var.aws_account_id
  aws_region                    = var.aws_region
  encryption_key_arn            = module.frontend_pipeline.encryption_key_arn
  ecr_repository_name           = module.ecr.ecr_repository_name
}

moved {
  from = module.code_build
  to   = module.frontend_build
}

module "frontend_pipeline" {
  source                 = "./modules/code_pipeline"
  repository_name        = var.frontend_repository
  project_name           = var.project_name
  aws_region             = var.aws_region
  codebuild_project_name = module.frontend_build.frontend_build_project_name
}

moved {
  from = module.code_pipeline
  to   = module.frontend_pipeline
}
module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
}
