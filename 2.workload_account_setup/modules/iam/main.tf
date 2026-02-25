
resource "aws_iam_policy" "terraform_management" {
  policy = data.aws_iam_policy_document.iam_management.json
  name   = "terraform_management_${var.environment}"
}

resource "aws_iam_role_policy_attachment" "attach_management_role" {
  policy_arn = aws_iam_policy.terraform_management.arn
  role       = aws_iam_role.management_account_assume_role.name
}

resource "aws_iam_role" "management_account_assume_role" {
  assume_role_policy = data.aws_iam_policy_document.management_account_assume_role.json
  name               = "management_account_assume_role_${var.environment}"
  path               = "/system/"
}
