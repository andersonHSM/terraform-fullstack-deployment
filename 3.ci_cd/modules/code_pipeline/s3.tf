resource "aws_s3_bucket" "code_pipeline" {
  bucket        = "code_pipeline"
  region        = var.region
  force_destroy = true
}
resource "aws_s3_bucket_versioning" "code_pipeline" {
  bucket = aws_s3_bucket.code_pipeline.arn
  region = var.region
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "code_pipeline" {
  bucket                  = aws_s3_bucket.code_pipeline.arn
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
