resource "aws_ecr_repository" "ecr" {
  name                 = "antraregistry"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

data "aws_ecr_authorization_token" "token"{
}

output "url" {
  value = aws_ecr_repository.ecr.repository_url
}

output "id" {
  value = data.aws_ecr_authorization_token.token.user_name
}

output "password" {
  value = data.aws_ecr_authorization_token.token.password
}