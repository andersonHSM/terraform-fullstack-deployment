resource "aws_cognito_user_pool" "user_pool" {
  name = "${var.user_pool_name}_${var.environment}"

  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = false
    name                     = "email"
    required                 = true

    string_attribute_constraints {
      min_length = 0
      max_length = 2048
    }
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "user_type"
    required                 = false

    string_attribute_constraints {
      min_length = 2
      max_length = 2
    }
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "app_user_id"
    required                 = false

    string_attribute_constraints {
      min_length = 0
      max_length = 2048
    }
  }

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_message        = "Your verification code is {####}"
    email_subject        = "Verify your email"
  }

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_cognito_user_pool_client" "client" {
  name = "${var.app_client_name}_${var.environment}"

  user_pool_id = aws_cognito_user_pool.user_pool.id

  generate_secret     = false
  explicit_auth_flows = ["ALLOW_USER_SRP_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_PASSWORD_AUTH"]
}
