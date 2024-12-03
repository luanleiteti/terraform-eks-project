output "cluster_id" {
  description = "ID do cluster EKS"
  value       = aws_eks_cluster.main.id
}

output "cluster_endpoint" {
  description = "Endpoint do cluster EKS"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_certificate_authority" {
  description = "Certificate authority do cluster"
  value       = aws_eks_cluster.main.certificate_authority[0].data
}

output "oidc_provider_arn" {
  description = "ARN do provedor OIDC"
  value       = aws_iam_openid_connect_provider.eks.arn
}

output "oidc_provider_url" {
  description = "URL do provedor OIDC"
  value       = aws_iam_openid_connect_provider.eks.url
}

output "service_account_role_arn" {
  description = "ARN da role da service account"
  value       = aws_iam_role.service_account.arn
}

output "node_group_role_arn" {
  description = "ARN da role do node group"
  value       = aws_iam_role.eks_node_group.arn
}
