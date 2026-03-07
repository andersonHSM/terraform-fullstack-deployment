resource "aws_codestarconnections_connection" "project" {
  name          = var.project_name
  provider_type = "GitHub"
  region        = var.aws_region
}

moved {
  from = aws_codepipeline.frontend
  to   = aws_codepipeline.project
}

resource "aws_codepipeline" "project" {
  name     = "${var.project_name}-${var.repository_name}-pipeline"
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
    name = "SourceMainBranch"

    action {
      category = "Source"
      name     = "Source"
      owner    = "AWS"
      provider = "CodeStarSourceConnection"
      version  = "1"
      output_artifacts = [
        local.source_output_artifact
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
    name = "SourceDevelopBranch"

    action {
      category = "Source"
      name     = "Source"
      owner    = "AWS"
      provider = "CodeStarSourceConnection"
      version  = "1"
      output_artifacts = [
        local.source_output_artifact
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
        local.source_output_artifact
      ]

      configuration = {
        ProjectName   = var.codebuild_project_name
        PrimarySource = local.source_output_artifact
      }
    }
  }

}
