locals {
  ci_cd_path             = "/ci-cd/"
  source_output_artifact = "${var.project_name}-${var.repository_name}-source-output-artifact"
  build_output_artifact  = "${var.project_name}-${var.repository_name}-build-output-artifact"
}
