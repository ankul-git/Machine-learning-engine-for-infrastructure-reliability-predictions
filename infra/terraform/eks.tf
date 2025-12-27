module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "pre-cluster"
  cluster_version = "1.29"

  subnet_ids = [] # we’ll add VPC later
  vpc_id     = ""

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      desired_size   = 2
    }
  }
}
