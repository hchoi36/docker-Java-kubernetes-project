data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  #load_config_file       = false
  #version                = "1.9"
}

module "eks" {
  source           = "terraform-aws-modules/eks/aws"
   version         = "17.24.0"
  cluster_name     = "Antra-Kubernetes"
  cluster_version  = "1.21"
  #subnets          = ["subnet-0f78a8893b01ab3b0","subnet-0e0112694839b9e7a"]
  #vpc_id = "vpc-071c9a3420aa5120a"
  subnets          = module.vpc.public_subnets
  vpc_id = module.vpc.vpc_id

  
  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      #additional_userdata           = "echo foo bar"
      #additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
      asg_desired_capacity          = 1
      #enable_monitoring = false 
    },
  ]
}

output "env-dynamic-url" {
   value = module.eks.cluster_endpoint
}
