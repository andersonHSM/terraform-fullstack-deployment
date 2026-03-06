data "aws_ecr_lifecycle_policy_document" "policies" {
  rule {
    priority    = 0
    description = "Expire untagged images older than 7 days"
    selection {
      count_unit   = "days"
      count_number = 7
      count_type   = "sinceImagePushed"
      tag_status   = "untagged"
    }
    action {
      type = "expire"
    }
  }

  rule {
    priority    = 1
    description = "Store 10 no production versioned images"
    selection {
      count_number    = 0
      count_type      = ""
      tag_status      = "tagged"
      tag_prefix_list = ["v*-alpha*", "v*-beta*"]
    }
    action {
      type = "expire"
    }
  }
}
