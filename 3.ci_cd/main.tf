module "iam" {
  source                = "./modules/iam"
  region                = var.region
  management_account_id = var.management_account_id
  providers = {
    aws.management = aws.management
    aws.qa         = aws.qa
    aws.prod       = aws.prod
  }
}

module "code_build" {
  source                        = "./modules/code_build"
  environment                   = var.environment
  backend_repository            = var.backend_repository
  frontend_repository           = var.frontend_repository
  repo_code_star_connection_arn = module.code_pipeline.repo_code_star_connection_arn
  output_artifact_bucket_name   = module.code_pipeline.output_artifact_bucket_name
  frontend_repository_url       = var.frontend_repository_url
  providers = {
    aws = aws.management
  }
}

module "code_pipeline" {
  source                      = "./modules/code_pipeline"
  backend_repository          = var.backend_repository
  frontend_repository         = var.frontend_repository
  project_name                = var.project_name
  region                      = var.region
  environment                 = var.environment
  code_star_connection_arn    = ""
  frontend_build_project_name = module.code_build.frontend_build_project_name
  providers = {
    aws = aws.management
  }
}
