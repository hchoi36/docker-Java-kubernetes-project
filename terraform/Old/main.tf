module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = var.instance_name

  ami                    = "ami-08e637cea2f053dfa"
  instance_type          = "t2.micro"
  key_name               = "devops_lab"
  #monitoring             = true
  #vpc_security_group_ids = ["sg-12345678"]
  #outputs public subnet id 
  subnet_id            = "${element(module.vpc.public_subnets, 0)}"
  
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}