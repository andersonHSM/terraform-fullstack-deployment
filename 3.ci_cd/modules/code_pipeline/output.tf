output "repo_code_star_connection_arn" {
  value = aws_codestarconnections_connection.project.arn
}

output "artifacts_bucket_name" {
  value = aws_s3_bucket.code_pipeline.bucket
}
output "artifacts_bucket_arn" {
  value = aws_s3_bucket.code_pipeline.arn
}
