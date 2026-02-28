resource "aws_codebuild_project" "frontend" {
  name         = local.frontend_project_name
  service_role = aws_iam_role.code_build.arn
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:nodejs22"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  artifacts {
    type                = "S3"
    bucket_owner_access = "FULL"
    artifact_identifier = "${var.frontend_repository}_build"
    name                = local.frontend_project_name
  }

  source {
    auth {
      resource = var.repo_code_star_connection_arn
      type     = "CODECONNECTIONS"
    }

    location = var.frontend_repository_url
    type     = "GITHUB"
  }

  concurrent_build_limit = 2
}

# resource "aws_codebuild_project" "backend" {
#   name         = "backend_builder_${var.environment}"
#   service_role = aws_iam_role.code_build.arn
#   source {
#     type = "GITHUB"
#   }
#   environment {
#     compute_type = ""
#     image        = ""
#     type         = ""
#   }
#
# }
