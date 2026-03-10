resource "aws_codestarconnections_connection" "project" {
  name          = var.project_name
  provider_type = "GitHub"
  region        = var.aws_region
}

moved {
  from = aws_codepipeline.frontend
  to   = aws_codepipeline.main_pipeline
}

resource "aws_codepipeline" "main_pipeline" {
  name           = "${var.project_name}-${var.repository_name}-main-pipeline"
  role_arn       = aws_iam_role.code_pipeline.arn
  execution_mode = "QUEUED"
  pipeline_type = "V2"

  artifact_store {
    location = aws_s3_bucket.code_pipeline.bucket
    type     = "S3"

    encryption_key {
      id   = data.aws_kms_alias.s3_kms_key.arn
      type = "KMS"
    }
  }

  trigger {
    provider_type = "CodeStarSourceConnection"
    git_configuration {
      source_action_name = "Source"
      pull_request {
        branches {
          includes = ["main"]
        }
        events = ["CLOSED"]
      }
    }
  }

  stage {
    name = "SourceMainBranch"

    action {
      category = "Source"
      name     = "Source"
      owner    = "AWS"
      provider = "CodeStarSourceConnection"
      version  = "1"
      output_artifacts = [
        local.main_source_output_artifact
      ]


      configuration = {
        BranchName           = "main"
        ConnectionArn        = aws_codestarconnections_connection.project.arn
        FullRepositoryId     = "${var.project_name}/${var.repository_name}"
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
        DetectChanges        = false
      }
    }
  }

  stage {
    name = "BuildOnCodeBuild"

    action {
      category = "Build"
      name     = "BuildonCodeBuild"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"

      output_artifacts = [
        local.build_output_artifact
      ]
      input_artifacts = [
        local.main_source_output_artifact
      ]

      configuration = {
        ProjectName   = var.codebuild_project_name
        PrimarySource = local.main_source_output_artifact
      }
    }
  }

}

resource "aws_codepipeline" "develop_pipeline" {
  name           = "${var.project_name}-${var.repository_name}-develop-pipeline"
  role_arn       = aws_iam_role.code_pipeline.arn
  execution_mode = "QUEUED"
  pipeline_type = "V2"


  trigger {
    provider_type = "CodeStarSourceConnection"
    git_configuration {
      source_action_name = "Source"
      pull_request {
        branches {
          includes = ["develop"]
        }
        events = ["CLOSED"]
      }
    }
  }

  artifact_store {
    location = aws_s3_bucket.code_pipeline.bucket
    type     = "S3"

    encryption_key {
      id   = data.aws_kms_alias.s3_kms_key.arn
      type = "KMS"
    }
  }

  stage {
    name = "SourceDevelopBranch"

    action {
      category = "Source"
      name     = "Source"
      owner    = "AWS"
      provider = "CodeStarSourceConnection"
      version  = "1"
      output_artifacts = [
        local.develop_source_output_artifact
      ]


      configuration = {
        BranchName           = "develop"
        ConnectionArn        = aws_codestarconnections_connection.project.arn
        FullRepositoryId     = "${var.project_name}/${var.repository_name}"
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
        DetectChanges        = false
      }
    }
  }

  stage {
    name = "BuildOnCodeBuild"

    action {
      category = "Build"
      name     = "BuildonCodeBuild"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"

      output_artifacts = [
        local.build_output_artifact
      ]
      input_artifacts = [
        local.develop_source_output_artifact
      ]

      configuration = {
        ProjectName   = var.codebuild_project_name
        PrimarySource = local.develop_source_output_artifact
      }
    }
  }

}

resource "aws_codepipeline" "pr_pipeline" {
  name           = "${var.project_name}-${var.repository_name}-pr-builder-pipeline"
  role_arn       = aws_iam_role.code_pipeline.arn
  execution_mode = "PARALLEL"
  pipeline_type = "V2"


  trigger {
    provider_type = "CodeStarSourceConnection"
    git_configuration {
      source_action_name = "Source"
      pull_request {
        branches {
          includes = ["**"]
        }
        events = ["OPEN", "UPDATED"]
      }
    }
  }

  artifact_store {
    location = aws_s3_bucket.code_pipeline.bucket
    type     = "S3"

    encryption_key {
      id   = data.aws_kms_alias.s3_kms_key.arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      category = "Source"
      name     = "Source"
      owner    = "AWS"
      provider = "CodeStarSourceConnection"
      version  = "1"
      output_artifacts = [
        local.develop_source_output_artifact
      ]

      configuration = {
        BranchName           = "develop"
        ConnectionArn        = aws_codestarconnections_connection.project.arn
        FullRepositoryId     = "${var.project_name}/${var.repository_name}"
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
        DetectChanges        = false
      }
    }
  }

  stage {
    name = "BuildOnCodeBuild"

    action {
      category = "Build"
      name     = "BuildonCodeBuild"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"

      output_artifacts = [
        local.build_output_artifact
      ]
      input_artifacts = [
        local.develop_source_output_artifact
      ]

      configuration = {
        ProjectName   = var.codebuild_pr_builder_project_name
        PrimarySource = local.develop_source_output_artifact
      }
    }
  }

}
