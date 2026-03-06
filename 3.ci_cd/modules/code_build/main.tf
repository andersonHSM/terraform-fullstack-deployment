
resource "aws_codebuild_project" "project" {
  name           = var.repository_name
  service_role   = aws_iam_role.code_build.arn
  badge_enabled  = true
  encryption_key = var.encryption_key_arn
  auto_retry_limit = 3

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "docker:dind"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = false

    environment_variable {
      name  = "SHELL"
      value = "bash"
    }

    environment_variable {
      name  = "project"
      value = var.repository_name
    }

    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = "${var.ecr_repository_name}_${var.repository_name}"
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
