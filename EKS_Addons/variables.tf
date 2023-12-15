# ###################################################################
# Network & Security variables
# ###################################################################
variable "vpc_id" {
  description = "ID of VPC in which resources will be created."
  type        = string
}
 
variable "subnet_ids" {
  description = "List of subnet ids in which resources are provisioned."
  type        = list(any)
}
 
variable "vpc_default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  type        = string
}
 
variable "alb_security_group_id" {
  description = "The ID of the ALB security group created"
  type        = string
  default     = ""
}
 
variable "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  type        = list(any)
}
 
variable "cluster_encryption_config" {
  description = "Configuration block with encryption configuration for the cluster. To disable secret encryption, set this value to `{}`"
  type        = any
  default = {
    resources = ["secrets"]
  }
}

# ###################################################################
# Kubernetes variables
# ###################################################################
variable "cluster_name" {
  description = "Name of your cluster"
  type        = string
}
 
variable "cluster_version" {
  description = "Version of Kubernetes to run"
  type        = string
  default     = "1.27"
}
 
variable "control_plane_subnet_ids" {
  description = "A list of subnet IDs where the EKS cluster control plane (ENIs) will be provisioned. Used for expanding the pool of subnets used by nodes/node groups without replacing the EKS control plane"
  type        = list(string)
  default     = []
}
 
variable "iam_role_additional_policies" {
  description = "Additional policies to be added to the IAM role"
  type        = map(string)
  default     = {}
}

# ###################################################################
# EKS Cluster Node Group
# ###################################################################
variable "eks_managed_node_groups" {
  description = "Map of EKS managed node group definitions to create"
  type        = any
  default     = {}
}
 
variable "eks_managed_node_group_defaults" {
  description = "Map of EKS managed node group default configurations"
  type        = any
  default     = {}
}

# ###################################################################
# CloudWatch Log Group
# ###################################################################
 
variable "create_cloudwatch_log_group" {
  description = "Determines whether a log group is created by this module for the cluster logs. If not, AWS will automatically create one if logging is enabled"
  type        = bool
  default     = true
}
 
variable "cloudwatch_log_group_retention_in_days" {
  description = "Number of days to retain log events. Default retention - 90 days"
  type        = number
  default     = 90
}
 
variable "cloudwatch_log_group_kms_key_id" {
  description = "If a KMS Key ARN is set, this key will be used to encrypt the corresponding log group. Please be sure that the KMS Key has an appropriate key policy (https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/encrypt-log-data-kms.html)"
  type        = string
  default     = null
}

# ###################################################################
# Generic variables
# ###################################################################
variable "tags" {
  description = "Map of custom tags to be added to the cluster resources"
  type        = any
  default     = {}
}