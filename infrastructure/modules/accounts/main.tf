resource "aws_organizations_account" "environment_account" {
  email                      = var.owner_email
  name                       = "deploy-${var.environment}"
  close_on_deletion          = true
  iam_user_access_to_billing = "ALLOW"
}



resource "aws_ssoadmin_account_assignment" "admin_access" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  permission_set_arn = var.sso_admin_permission_set_arn
  principal_id       = data.aws_identitystore_group.admin.id
  principal_type     = "GROUP"
  target_id          = aws_organizations_account.environment_account.id
  target_type        = "AWS_ACCOUNT"
}
