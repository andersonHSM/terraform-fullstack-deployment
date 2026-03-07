
resource "aws_codebuild_project" "project" {
  name             = var.repository_name
  service_role     = aws_iam_role.code_build.arn
  badge_enabled    = true
  encryption_key   = var.encryption_key_arn
  auto_retry_limit = 3


  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

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
      value = var.ecr_repository_name
    }

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.aws_region
    }

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.current.account_id
    }
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }



  source {
    git_clone_depth = 0

    git_submodules_config {
      fetch_submodules = true
    }

    report_build_status = true

    auth {
      resource = var.repo_code_star_connection_arn
      type     = "CODECONNECTIONS"
    }

    location = var.repository_url
    type     = "GITHUB"
  }

  concurrent_build_limit = 2

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
  }

}

moved {
  from = aws_codebuild_project.frontend
  to   = aws_codebuild_project.project
}
