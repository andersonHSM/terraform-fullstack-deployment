output "docker_build_project_name" {
  value = aws_codebuild_project.project.name
}

output "pr_builder_project_name" {
  value = aws_codebuild_project.pr_builder.name
}

