module "eks_blueprints" {
  source = "aws-ia/eks-blueprints-addons/aws"

  cluster_name      = local.cluster_name
  cluster_version   = local.cluster_version
  cluster_endpoint  = module.eks.cluster_endpoint
  oidc_provider_arn = module.eks.oidc_provider_arn

  # Enable native Amazon EKS add-ons
  eks_addons = {
    vpc-cni = {
      most_recent = true
    },
    aws-ebs-csi-driver = {
      most_recent = true
    },
    coredns = {
      most_recent = true
    },
    kube-proxy = {
      most_recent = true
    },
    adot = {
      most_recent = true
    },
    aws-guardduty-agent = {
      most_recent = true
    }
  }

  # Third-Party Add-Ons
  enable_aws_efs_csi_driver = true
  enable_metrics_server     = true
  enable_cluster_autoscaler = true
  enable_external_secrets   = true

  enable_aws_load_balancer_controller = true
  aws_load_balancer_controller = {
    service_account_name = "alb-controller-sa"
  }

  enable_external_dns = true
  external_dns = {
    namespace = "kube-system"
  }

  # AWS for Fluent-bit
  enable_aws_for_fluentbit = true
  aws_for_fluentbit = {
    namespace = "kube-system"
  }
  # CloudWatch Log Group
  aws_for_fluentbit_cw_log_group = {
    create          = true
    use_name_prefix = false
    name            = "/aws/eks/${local.cluster_name}/aws-fluentbit-logs"
    retention       = 90
  }
}