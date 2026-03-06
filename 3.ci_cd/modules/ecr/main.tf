resource "aws_ecr_repository" "project" {
  name = "${var.project_name}/${var.project_scope}"
}


resource "aws_ecr_account_setting" "basic_scan_type_version" {
  name  = "BASIC_SCAN_TYPE_VERSION"
  value = "AWS_NATIVE"
}

resource "aws_ecr_account_setting" "blob_mounting" {
  name  = "BLOB_MOUNTING"
  value = "ENABLED"
}

resource "aws_ecr_lifecycle_policy" "expiration" {
  policy     = data.aws_ecr_lifecycle_policy_document.policies.json
  repository = aws_ecr_repository.project.name
}
