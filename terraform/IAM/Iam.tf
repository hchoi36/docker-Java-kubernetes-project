resource "aws_iam_user" "dev" {
  name = "dev"
}

resource "aws_iam_access_key" "ack" {
  user = aws_iam_user.dev.name
}

output "access_key" {
  value = aws_iam_access_key.ack.id 
}

resource "aws_iam_user_policy" "iam" {
  name = "EC2"
  user = aws_iam_user.dev
  policy = <<EOF
  {
    "Version": "2022-1-6",
    "Statement": [
    {
    "Effect": "Allow",
    "Action": "ec2:*",
    "Resource": "*"

    }
    ] 
  }
  EOF
}


# resource "aws_iam_role" "test_role" {
#   name = "test_role"

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       },
#     ]
#   })
 
#   tags = {
#     tag-key = "test"
#   }
# }