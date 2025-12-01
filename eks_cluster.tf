module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"
  addons = {
    aws-ebs-csi-driver = {
      addon_version            = "v1.33.0-eksbuild.1" # Match your EKS version
      resolve_conflicts        = "OVERWRITE"
      service_account_role_arn = module.ebs_csi_irsa_role.iam_role_arn
    }
    coredns                = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = {}
    vpc-cni                = {
      before_compute = true
    }
  }

  # Optional
  endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  name    = "apex"
  kubernetes_version = "1.33"
  subnet_ids        = [aws_subnet.prvate_sub_us-east-1b.id, aws_subnet.prvate_sub_us-east-1a.id]
  vpc_id          = aws_vpc.eks_blueprints.id
  enable_irsa     = true

  eks_managed_node_groups = {
    general = {
      desired_capacity = 1
      max_capacity     = 5
      min_capacity     = 1
      instance_types   = ["t3a.xlarge"]
      capacity_type    = "ON_DEMAND"
    }
  }
}