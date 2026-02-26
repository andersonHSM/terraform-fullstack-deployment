resource "aws_codebuild_project" "environment_builder" {
  name         = "frontend_builder_${var.environment}"
  service_role = aws_iam_role.code_build.arn
  environment {
    compute_type = ""
    image        = ""
    type         = ""
  }

}
