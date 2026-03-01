resource "aws_codestarconnections_connection" "project" {
  name          = var.project_name
  provider_type = "GitHub"
  region        = var.region
}

resource "aws_codepipeline" "frontend" {
  name     = "${var.project_name}-frontend-pipeline"
  role_arn = aws_iam_role.code_pipeline.arn

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
        local.frontend_source_output_artifact
      ]

      configuration = {
        BranchName       = "main"
        ConnectionArn    = aws_codestarconnections_connection.project.arn
        FullRepositoryId = "${var.project_name}/${var.frontend_repository}"
      }
    }
  }

  stage {
    name = "Build"

    action {
      category = "Build"
      name     = "BuildonCodeBuild"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"

      output_artifacts = [
        local.frontend_build_output_artifact
      ]
      input_artifacts = [
        local.frontend_source_output_artifact
      ]

      configuration = {
        ProjectName   = var.frontend_build_project_name
        PrimarySource = local.frontend_source_output_artifact
      }
    }
  }
}
