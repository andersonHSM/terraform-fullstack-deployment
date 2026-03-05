resource "aws_codebuild_project" "project" {
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
    type = "NO_ARTIFACTS"
  }



  source {
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }

    auth {
      resource = var.repo_code_star_connection_arn
      type     = "CODECONNECTIONS"
    }

    location = var.repository_url
    type     = "GITHUB"
  }

  concurrent_build_limit = 2
}

moved {
  from = aws_codebuild_project.frontend
  to   = aws_codebuild_project.project
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
