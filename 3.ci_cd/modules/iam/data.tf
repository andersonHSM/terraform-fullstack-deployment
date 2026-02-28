data "aws_ssoadmin_instances" "sso" {}

data "aws_identitystore_users" "users" {
  identity_store_id = data.aws_ssoadmin_instances.sso.identity_store_ids[0]
}

data "aws_identitystore_group" "admin" {
  identity_store_id = data.aws_ssoadmin_instances.sso.identity_store_ids[0]
  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = "Admins"
    }
  }
}

data "aws_iam_policy_document" "code_star_connections_admin_access" {
  statement {
    effect = "Allow"
    actions = [
      "codeconnections:UseConnection",
      "codeconnections:GetConnectionToken"
    ]
    resources = [
      provider::aws::arn_build("aws", "codestar-connections", var.region, var.management_account_id, "connection/*")
    ]
  }
}

data "aws_ssoadmin_permission_set" "admin" {
  instance_arn = data.aws_ssoadmin_instances.sso.arns[0]
  name         = "AdminAccess"
}
