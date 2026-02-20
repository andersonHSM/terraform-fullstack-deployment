data "aws_ssoadmin_instances" "instances" {}

data "aws_identitystore_user" "admin_user" {
  identity_store_id = data.aws_ssoadmin_instances.instances.identity_store_ids[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "UserName"
      attribute_value = var.sso_admin_username_to_attach_to_account
    }
  }
}

data "aws_ssoadmin_permission_set" "admin_access" {
  instance_arn = data.aws_ssoadmin_instances.instances.arns[0]

}

data "aws_identitystore_group" "admin" {
  identity_store_id = data.aws_ssoadmin_instances.instances.identity_store_ids[0]
  group_id          = var.sso_admin_group_id
}
