data "aws_ecr_lifecycle_policy_document" "policies" {
  rule {
    priority    = 1
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
    priority    = 2
    description = "Store 10 non production versioned images"
    selection {
      count_number     = 10
      count_type       = "imageCountMoreThan"
      tag_status       = "tagged"
      tag_pattern_list = ["*alpha*", "*beta*"]
    }
    action {
      type = "expire"
    }
  }

  rule {
    priority    = 3
    description = "Store 20 versioned images at max"
    selection {
      count_number     = 20
      count_type       = "imageCountMoreThan"
      tag_status       = "any"
    }
    action {
      type = "expire"
    }
  }
}
