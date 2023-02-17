resource "aws_ecr_repository" "ecr" {
  name                 = "antraregistry"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

data "aws_ecr_authorization_token" "token"{
}

output "container_registry" {
  value = aws_ecr_repository.ecr.repository_url
}

# output "container_registry_credentials" {
#   value = {
#     username = aws_ecr_repository.ecr.name
#     password = aws_ecr_repository.ecr.registry_id
#   }
#}
