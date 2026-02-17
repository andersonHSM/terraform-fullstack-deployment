resource "aws_organizations_account" "account" {
  email                      = var.owner_email
  name                       = "deploy-${var.environment}"
  close_on_deletion          = true
  iam_user_access_to_billing = "ALLOW"
}

resource "aws_ssoadmin_permission_set" "admin_access" {
  name             = "AdministratorAcces"
  description      = "Allow"
  instance_arn     = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  session_duration = "PT1H"
}

resource "aws_identitystore_group" "admin_group" {
  display_name      = "AdminGroup"
  identity_store_id = "Admin Group"
}

resource "aws_identitystore_user" "admin_user" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.instances.identity_store_ids)[0]

  display_name = var.sso_admin_display_name_to_attach_to_account
  user_name    = var.sso_admin_user_to_attach_to_account

  name {
    given_name  = var.sso_admin_name_to_attach_to_account
    family_name = var.sso_admin_family_name_to_attach_to_account
  }

  emails {
    value = var.sso_admin_email_to_attach_to_account
  }

  depends_on = [aws_organizations_account.account]
}

resource "aws_identitystore_group_membership" "assign_admin_to_group" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.instances.identity_store_ids)[0]
  group_id          = aws_identitystore_group.admin_group.group_id
  member_id         = aws_identitystore_user.admin_user.user_id
  depends_on        = [aws_identitystore_user.admin_user]
}

resource "aws_ssoadmin_account_assignment" "basic_admin_account" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.admin_access.arn

  principal_id   = aws_identitystore_group.admin_group.group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.account.id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_managed_policy_attachment" "admin_aws_managed_policy" {
  # Adding an explicit dependency on the account assignment resource will
  # allow the managed attachment to be safely destroyed prior to the removal
  # of the account assignment.
  depends_on = [aws_ssoadmin_account_assignment.basic_admin_account]

  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  permission_set_arn = aws_ssoadmin_permission_set.admin_access.arn
}

