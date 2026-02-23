data "aws_ssoadmin_instances" "instances" {}

data "aws_ssoadmin_permission_set" "admin_access" {
  instance_arn = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  arn          = var.sso_admin_permission_set_arn

}

data "aws_identitystore_group" "admin" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.instances.identity_store_ids)[0]
  group_id          = var.sso_admin_group_id
}
