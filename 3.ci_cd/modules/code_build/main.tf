resource "aws_codebuild_project" "frontend" {
  name         = "frontend_builder_${var.environment}"
  service_role = aws_iam_role.code_build.arn
  environment {
    compute_type = ""
    image        = ""
    type         = ""
  }

}

resource "aws_codebuild_project" "backend" {
  name         = "backend_builder_${var.environment}"
  service_role = aws_iam_role.code_build.arn
  source {
    type = "GITHUB"
  }
  environment {
    compute_type = ""
    image        = ""
    type         = ""
  }

}
