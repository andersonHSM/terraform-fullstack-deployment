data "aws_iam_policy_document" "management_account_assume_role" {
  statement {
    sid = "1"
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      identifiers = [
        var.management_account_user_arn
      ]
      type = "AWS"
    }
  }
}

data "aws_iam_policy_document" "terraform_management" {
  statement {
    sid    = "Statement1"
    effect = "Allow"

    actions = [
      "iam:ListAttachedRolePolicies",
      "iam:ListAttachedUserPolicies",
      "iam:ListCloudFrontPublicKeys",
      "iam:ListGroups",
      "iam:ListGroupsForUser",
      "iam:ListPolicies",
      "iam:ListRoles",
      "iam:ListPolicyVersions",
      "iam:ListUsers",
      "iam:GetGroup",
      "iam:GetGroupPolicy",
      "iam:GetUserPolicy",
      "iam:GetRolePolicy",
      "iam:GetPolicyVersion",
      "iam:GetPolicy",
      "iam:GetRole",
      "iam:CreateRole",
      "iam:CreateServiceLinkedRole",
      "iam:DeleteRole",
      "iam:PassRole",
      "iam:UpdateRole",
      "iam:UpdateRoleDescription",
      "iam:AttachRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:DetachRolePolicy",
      "iam:DeleteRolePermissionsBoundary",
      "iam:PutRolePermissionsBoundary",
      "iam:PutRolePolicy",
      "iam:UpdateAssumeRolePolicy",
      "iam:TagRole",
      "iam:UntagRole",
    ]

    condition {
      test     = "Null"
      values   = [true]
      variable = "aws:AssumedRoot"
    }
    condition {
      test     = "ArnLike"
      values   = [var.management_account_user_arn]
      variable = "aws:PrincipalArn"
    }
    resources = [
      aws_iam_role.management_account_assume_role.arn
    ]
  }
}
