output "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider if `enable_irsa = true`"
  value       = try(module.eks.oidc_provider_arn, null)
}
 
output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = try(module.eks.cluster_endpoint, null)
}
 
output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = try(module.eks.cluster_certificate_authority_data, null)
}