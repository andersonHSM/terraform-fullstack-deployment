resource "aws_codepipeline" "frontend" {
  name     = "${var.project_name}_frontend"
  role_arn = ""
}
