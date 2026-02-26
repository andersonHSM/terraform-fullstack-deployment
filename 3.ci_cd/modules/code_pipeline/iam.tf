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

data "aws_iam_policy_document" "code_pipeline_policy" {

}
