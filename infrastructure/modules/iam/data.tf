data "aws_iam_policy_document" "allow_terraform_user_to_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = [aws_iam_user.terraform_user.arn]
      type        = "AWS"
    }
  }
  provider = aws.target
}

data "aws_iam_policy" "s3_full_access" {
  arn      = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  provider = aws.target
}
