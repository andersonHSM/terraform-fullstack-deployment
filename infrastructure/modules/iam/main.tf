resource "aws_iam_user" "terraform" {
  name = "terraform_user_${var.environment}"
  path = "/system/"
  tags = {
    providedBy = "terraform"
  }
}

resource "aws_iam_role" "allow_assume_role" {
  assume_role_policy = aws_iam_policy.assume_role.arn
  path               = "/system/"
}

resource "aws_iam_policy" "terraform_state_object_management" {
  policy = data.aws_iam_policy_document.terraform_state_object_management.json
  name   = "terraform_state_object_management"
  path   = "/system/"
}

resource "aws_iam_access_key" "terraform" {
  user    = aws_iam_user.terraform.arn
  pgp_key = "keybase:Anderson"
}

resource "aws_iam_policy" "assume_role" {
  policy = data.aws_iam_policy_document.cross_account_assume_role.json
  name   = "cross_account_assume_role"
  path   = "/system/"
}

resource "aws_secretsmanager_secret" "key" {
  name = "${aws_iam_user.terraform.name}_secret_key"
}
resource "aws_secretsmanager_secret_version" "key" {
  secret_id     = aws_secretsmanager_secret.key.id
  secret_string = aws_iam_access_key.terraform.secret
}
