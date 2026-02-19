terraform {
  required_version = ">= 1.6.0"
  backend "local" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws" # Specify the source of the AWS provider
      version = "~> 6.32"       # Use a version of the AWS provider that is compatible with version
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.state_bucket_name

  tags = {
    Name        = "Terraform State"
    Environment = var.environment
    ManagedBy   = "terraform-bootstrap"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    id     = "expire-old-versions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }

  rule {
    id     = "abort-incomplete-uploads"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

resource "aws_identitystore_group" "admin" {
  display_name      = "Admins"
  description = "The group that hold administrative users with access throughout organization accounts"
  identity_store_id = data.aws_ssoadmin_instances.instances.identity_store_ids[0]
}



resource "aws_identitystore_user" "admin" {
  display_name      = var.admin_display_name
  identity_store_id = data.aws_ssoadmin_instances.instances.identity_store_ids[0]
  user_name         = var.admin_username
  name {
    given_name  = var.admin_name
    family_name = var.admin_family_name
  }

  title = "The Core Admin"

  emails {
    primary = true
    value   = var.admin_primary_email
  }
}

resource "aws_ssoadmin_permission_set" "admin" {
  name         = "AdminAccess"
  instance_arn = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
}


resource "aws_ssoadmin_account_assignment" "admin" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.admin.arn

  principal_id   = aws_identitystore_group.admin.group_id
  principal_type = "GROUP"

  target_id   = data.aws_caller_identity.identity.account_id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_managed_policy_attachment" "admin" {
  # Adding an explicit dependency on the account assignment resource will
  # allow the managed attachment to be safely destroyed prior to the removal
  # of the account assignment.
  depends_on = [aws_ssoadmin_account_assignment.admin]

  instance_arn       = tolist(data.aws_ssoadmin_instances.instances.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  permission_set_arn = aws_ssoadmin_permission_set.admin.arn
}

resource "aws_identitystore_group_membership" "admin_assignment" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.instances.identity_store_ids)[0]
  group_id          = aws_identitystore_group.admin.group_id
  member_id         = aws_identitystore_user.admin.user_id
}
