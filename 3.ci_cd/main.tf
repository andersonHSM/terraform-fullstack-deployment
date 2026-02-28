
module "code_build" {
  source              = "./modules/code_build"
  environment         = var.environment
  backend_repository  = var.backend_repository
  frontend_repository = var.frontend_repository
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
}
