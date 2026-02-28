resource "aws_iam_policy" "code_start_connection_admin_access" {
  policy = data.aws_iam_policy_document.code_star_connections_admin_access.json
  name   = "admin-group-code-star-connections-access"
}

resource "aws_ssoadmin_customer_managed_policy_attachment" "code_start_connection_admin_access" {
  instance_arn       = data.aws_ssoadmin_instances.sso.identity_store_ids[0]
  permission_set_arn = data.aws_ssoadmin_permission_set.admin.arn
  customer_managed_policy_reference {
    name = aws_iam_policy.code_start_connection_admin_access.name
  }
}
