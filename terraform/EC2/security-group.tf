resource "aws_security_group" "AntraSG" {
  name_prefix = "AntraSG"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/16",
    ]
  }

  ingress {
    from_port = 0
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = [
     "172.21.0.0/16",
    ]
  }
}
