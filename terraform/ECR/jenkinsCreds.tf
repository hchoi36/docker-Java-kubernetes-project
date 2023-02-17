provider "jenkins" {
  url      = "http://192.168.2.20:8080"
  username = "Choi"
  password = "choi"
}

resource "jenkins_credentials" "my_credentials" {
  id       = "ECR_registry"
  username = data.aws_ecr_authorization_token.token.user_name
  password = data.aws_ecr_authorization_token.token.password
  description = "My ECR Credential"
  scope    = "GLOBAL"
  domain   = "jenkins"
}

# resource "jenkins_credentials_aws_ecr" "my_ecr_credentials" {
#   id          = "my-ecr-credential-id"
#   description = "My ECR Credential"
#   access_key  = "my-aws-access-key"
#   secret_key  = "my-aws-secret-key"
# }