module "eks_blueprints_addons" {
  source = "aws-ia/eks-blueprints-addons/aws"
  version = "~> 1.0" #ensure to update this to the latest/desired version

  cluster_name      = module.eks.cluster_name
  cluster_endpoint  = "https://5E6B167D03F6A611F0E99B72038F8851.gr7.us-east-1.eks.amazonaws.com"
  cluster_version   = module.eks.cluster_version
  oidc_provider_arn = module.eks.oidc_provider_arn


  //enable_aws_load_balancer_controller    = true
  enable_cluster_proportional_autoscaler = true
  enable_karpenter                       = true
  enable_kube_prometheus_stack           = true
  enable_metrics_server                  = true
  //enable_external_dns                    = true
  enable_cert_manager                    = true
  enable_argocd = true
  enable_aws_cloudwatch_metrics = true

}

