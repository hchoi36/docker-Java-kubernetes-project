resource "aws_instance" "ec2" {
  ami = "ami-08e637cea2f053dfa"
  instance_type = "t2.micro"
  key_name = "devops_lab"
  vpc_security_group_ids = [aws_security_group.AntraSG.id]
  subnet_id = "${element(module.vpc.public_subnets, 0)}"



  user_data = <<EOF
		#!/bin/bash
    sudo yum update -y
    sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo --no-check-certificate
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
    sudo yum install jenkins -y
    sudo systemctl start jenkins
    sudo systemctl enable jenkins
	EOF

  tags = {
    Name = var.instance_name
  }
}

#resource "aws_s3_bucket" "b" {
  #bucket = "antra-tf-bucket"

  #tags = {
    #Name        = "My bucket"
    #Environment = "Dev"
  #}
#}

#resource "aws_s3_bucket_acl" "example" {
  #bucket = aws_s3_bucket.b.id
  #acl    = "private"
#}







 


