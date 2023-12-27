module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.15"

  cluster_name    = local.cluster_name
  cluster_version = local.cluster_version

  vpc_id     = local.vpc_id
  subnet_ids = local.subnet_ids

  control_plane_subnet_ids       = local.control_plane_subnet_ids
  cluster_endpoint_public_access = true #Depending on the client requirements
  cluster_encryption_config      = local.cluster_encryption_config

  # aws-auth configmap
  manage_aws_auth_configmap = true

  # EKS Managed Node Group(s)
  eks_managed_node_groups = local.eks_managed_node_groups

  # CloudWatch
  create_cloudwatch_log_group            = local.create_cloudwatch_log_group
  cloudwatch_log_group_retention_in_days = local.cloudwatch_log_group_retention_in_days
  cloudwatch_log_group_kms_key_id        = local.cloudwatch_log_group_kms_key_id
}
