# Outputs
output "cluster_endpoint" {
  description = "Endpoint do cluster EKS"
  value       = module.eks.cluster_endpoint
}

output "cluster_id" {
  description = "ID do cluster EKS"
  value       = module.eks.cluster_id
}

output "service_account_role_arn" {
  description = "ARN da role da service account"
  value       = module.eks.service_account_role_arn
}