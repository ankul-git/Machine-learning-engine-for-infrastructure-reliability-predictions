module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "pre-cluster"
  cluster_version = "1.29"

  # VPC Configuration
  vpc_id     = module.vpc.vpc_id
  subnet_ids = concat(module.vpc.private_subnets, module.vpc.public_subnets)

  # Cluster endpoint access
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  # EKS Managed Node Groups
  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      desired_size   = 2
      min_size       = 1
      max_size       = 3

      # Node group configuration
      disk_size = 20
      
      labels = {
        Environment = "pre-cluster"
        ManagedBy   = "terraform"
      }

      tags = {
        Name        = "pre-cluster-node"
        Environment = "pre-cluster"
      }
    }
  }

  # Cluster access entry - allows IAM user to access the cluster
  enable_cluster_creator_admin_permissions = true

  # Tags
  tags = {
    Environment = "pre-cluster"
    Terraform   = "true"
    ManagedBy   = "terraform"
  }
}

# Output the cluster endpoint
output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

# Output the cluster name
output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

# Output the kubectl config command
output "configure_kubectl" {
  description = "Configure kubectl: run the following command to update your kubeconfig"
  value       = "aws eks update-kubeconfig --region us-east-1 --name ${module.eks.cluster_name}"
}
