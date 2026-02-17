data "aws_ssoadmin_instances" "instances" {}

data "aws_identitystore_user" "admin_user" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.instances.identity_store_ids)[0]
  depends_on        = [aws_identitystore_user.admin_user]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "UserName"
      attribute_value = "andersonmenezes_admin"
    }
  }
}

