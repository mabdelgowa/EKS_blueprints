provider "aws" {
  region = "us-east-1"
}
provider "kubernetes" {
  config_path = "D:\\Apex_EKS\\EKS_blueprints\\kubeconfig.yml"
  host      =   module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = ["eks", "get-token", "--cluster-name", "apex"]
  }
}
data "aws_eks_cluster_auth" "current" {
  # You need to replace "module.eks.cluster_name" with the actual
  # Terraform reference that outputs your EKS cluster's name.
  # This might be different depending on your EKS Blueprint module structure.
  name = "apex"
}
provider "helm" {
  # Helm provider uses the Kubernetes provider block internally
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.current.token
  }
}