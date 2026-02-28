data "aws_iam_policy_document" "code_build_assume_role" {
  statement {
    sid = "AllowCodeBuildToAssumeRole"

    effect = "Allow"

    principals {
      identifiers = ["codebuild.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "code_build_role_permissions" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs",
    ]

    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["ec2:CreateNetworkInterfacePermission"]
    resources = ["arn:aws:ec2:us-east-1:123456789012:network-interface/*"]

    # condition {
    #   test     = "StringEquals"
    #   variable = "ec2:Subnet"
    #
    #   values = [
    #     aws_subnet.example1.arn,
    #     aws_subnet.example2.arn,
    #   ]
    # }

    condition {
      test     = "StringEquals"
      variable = "ec2:AuthorizedService"
      values   = ["codebuild.amazonaws.com"]
    }
  }

  statement {
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      var.artifacts_bucket_arn,
      "${var.artifacts_bucket_arn}/*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "codeconnections:GetConnectionToken",
      "codeconnections:GetConnection"
    ]
    resources = [var.repo_code_star_connection_arn]
  }
}


resource "aws_iam_role" "code_build" {
  assume_role_policy = data.aws_iam_policy_document.code_build_assume_role.json
  name               = "code_build_role"
  path               = "/ci/"
}

resource "aws_iam_role_policy" "code_build_permissions" {
  policy = data.aws_iam_policy_document.code_build_role_permissions.json
  role   = aws_iam_role.code_build.name
  name   = "code_build_permissions"
}
