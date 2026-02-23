resource "aws_iam_user" "terraform" {
  name = "terraform_user_${var.environment}"
  path = "/system/"
  tags = {
    providedBy = "terraform"
  }
}

resource "aws_iam_role" "allow_assume_role" {
  assume_role_policy = data.aws_iam_policy_document.cross_account_assume_role.json
  path               = "/system/"
  name               = "terraform_assume_role"
}

resource "aws_iam_policy" "terraform_state_object_management" {
  policy = data.aws_iam_policy_document.terraform_state_object_management.json
  name   = "terraform_state_object_management"
  path   = "/system/"
}

resource "aws_iam_role_policy_attachment" "assume_role_s3_state_management" {
  role       = aws_iam_role.allow_assume_role.name
  policy_arn = aws_iam_policy.terraform_state_object_management.arn
}

resource "aws_iam_access_key" "terraform" {
  user    = aws_iam_user.terraform.name
  pgp_key = "keybase:Anderson"
}

resource "aws_secretsmanager_secret" "access_key" {
  name = "${aws_iam_user.terraform.name}_access_key_1"

}

resource "aws_secretsmanager_secret" "secret_key" {
  name = "${aws_iam_user.terraform.name}_secret_key_1"
}

resource "aws_secretsmanager_secret_version" "secret_key" {
  secret_id     = aws_secretsmanager_secret.secret_key.id
  secret_string = aws_iam_access_key.terraform.encrypted_secret
}

resource "aws_secretsmanager_secret_version" "access_key" {
  secret_id     = aws_secretsmanager_secret.access_key.id
  secret_string = aws_iam_access_key.terraform.id
}
