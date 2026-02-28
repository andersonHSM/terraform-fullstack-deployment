data "aws_iam_policy_document" "code_pipeline_assume_role" {
  statement {
    sid    = "AllowCodePipelineToAssumeRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      identifiers = [
        "codepipeline.amazonaws.com"
      ]
      type = "Service"
    }
  }
}

resource "aws_iam_role" "code_pipeline" {
  name               = "code_pipeline_role"
  assume_role_policy = data.aws_iam_policy_document.code_pipeline_assume_role.json
  path               = local.ci_cd_path
}

data "aws_iam_policy_document" "codepipeline_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObjectAcl",
      "s3:PutObject",
    ]

    resources = [
      aws_s3_bucket.code_pipeline.arn,
      "${aws_s3_bucket.code_pipeline.arn}/*"
    ]
  }

  statement {
    effect    = "Allow"
    actions   = ["codestar-connections:UseConnection"]
    resources = [aws_codestarconnections_connection.frontend.arn]
  }

  statement {
    effect = "Allow"

    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "codepipeline_policy"
  role   = aws_iam_role.code_pipeline.id
  policy = data.aws_iam_policy_document.codepipeline_policy.json
}

data "aws_kms_alias" "s3_kms_key" {
  name = "alias/aws/s3"
}
