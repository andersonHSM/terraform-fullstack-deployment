variable "backend_config" {
  type = map(string)
  default = {
    bucket  = "curso-deploy-fullstack-state-2026"
    key     = "qa/auth/terraform.tfstate"
    profile = "anderson_admin_roadmap"
    region  = "us-east-1"
  }

}