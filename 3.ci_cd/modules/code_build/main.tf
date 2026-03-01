resource "aws_codebuild_project" "frontend" {
  name          = local.frontend_project_name
  service_role  = aws_iam_role.code_build.arn
  badge_enabled = true

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "SHELL"
      value = "bash"
    }
  }

  artifacts {
    type                = "S3"
    bucket_owner_access = "FULL"
    artifact_identifier = "${var.frontend_repository}_build"
    name                = local.frontend_project_name
    location            = var.artifacts_bucket_name
    encryption_disabled = true
  }



  source {
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }

    buildspec = ".config/buildspec.yml"
    auth {
      resource = var.repo_code_star_connection_arn
      type     = "CODECONNECTIONS"
    }

    location = var.frontend_repository_url
    type     = "GITHUB"
  }

  cache {
    type     = "S3"
    location = var.artifacts_bucket_name
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
