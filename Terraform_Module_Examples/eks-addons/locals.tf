locals {
  aws_region = "eu-west-1"

  # ###################################################################
  # Networking
  # ###################################################################
  vpc_id     = "your-vpc-id"
  subnet_ids = ["your-subnet-id1", "your-subnet-id2"]

  # ###################################################################
  # EKS
  # ###################################################################
  cluster_name              = "mycluster"
  cluster_version           = "1.27"
  cluster_encryption_config = {}
  kubeconfig = {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", local.cluster_name]
    }
  }

  eks_managed_node_group_defaults = {
    iam_role_additional_policies = {
      AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      AmazonS3FullAccess           = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    }
  }

  eks_managed_node_groups = {
    eks-default = {
      instance_types = ["t3.medium"]
      min_size       = 2
      max_size       = 3
      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size = 20
            volume_type = "gp3"
          }
        }
      }
    }
  }

  control_plane_subnet_ids = []

  # ###################################################################
  # Cloudwatch
  # ###################################################################
  create_cloudwatch_log_group            = true
  cloudwatch_log_group_retention_in_days = 90
  cloudwatch_log_group_kms_key_id        = null
}
