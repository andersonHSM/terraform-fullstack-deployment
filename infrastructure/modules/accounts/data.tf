data "aws_ssoadmin_instances" "instances" {}

data "aws_identitystore_user" "example" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.instances.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "UserName"
      attribute_value = "anderson_admin"
    }
  }
}

