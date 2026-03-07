locals {
  ci_cd_path                     = "/ci-cd/"
  main_source_output_artifact    = "${var.project_name}-${var.repository_name}-main-source-output-artifact"
  develop_source_output_artifact = "${var.project_name}-${var.repository_name}-develop-source-output-artifact"
  build_output_artifact          = "${var.project_name}-${var.repository_name}-build-output-artifact"
}
