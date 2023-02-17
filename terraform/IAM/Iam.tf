resource "aws_iam_user" "dev" {
  name = "dev"
}

resource "aws_iam_access_key" "ack" {
  user = aws_iam_user.dev.name
}

output "access_key" {
  value = aws_iam_access_key.ack.id 
}

#encrypted_secret with pgp key specified can be used instead then decrypt with terraform output -raw encrypted_secret | base64 --decode | keybase pgp decrypt 
output "secret" {
  value = aws_iam_access_key.ack.secret 
}

resource "aws_iam_user_policy" "iam" {
  name = "EC2"
  user = aws_iam_user.dev.name
  policy = jsonencode(
  {
    Version: "2012-10-17",
    Statement: [
    {
      Effect: "Allow",
      Action: ["ec2:*",]
      Resource: "*"
    },
    ]
  }
  )
}

# resource "aws_iam_role" "test_role" {
#   name = "test_role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           #Service = "ec2.amazonaws.com"
#           AWS: "aws_iam_user.dev.arn"
#         }
#       },
#     ]
#   })
 
#   tags = {
#     tag-key = "test"
#   }
# }