resource "aws_s3_bucket" "code_pipeline" {
  bucket        = "psibag-code-artifacts"
  region        = var.region
  force_destroy = true
}
resource "aws_s3_bucket_versioning" "code_pipeline" {
  bucket = aws_s3_bucket.code_pipeline.bucket
  region = var.region
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "code_pipeline" {
  bucket                  = aws_s3_bucket.code_pipeline.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "code_pipeline" {
  bucket = aws_s3_bucket.code_pipeline.bucket
  rule {

    id     = "MonthlyPipelinedArtifactsExpriation"
    status = "Enabled"
    filter {
      prefix = "/${aws_codepipeline.frontend.name}"
    }
    expiration {
      days = 30
    }
    noncurrent_version_expiration {
      noncurrent_days           = 30
      newer_noncurrent_versions = 5
    }
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
    noncurrent_version_transition {
      noncurrent_days = 7
      storage_class   = "GLACIER_IR"
    }
  }
}
