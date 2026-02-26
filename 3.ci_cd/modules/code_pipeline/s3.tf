resource "aws_s3_bucket" "code_pipeline" {
  bucket        = "code_pipeline"
  bucket_prefix = local.ci_cd_path
  region        = var.region
}
