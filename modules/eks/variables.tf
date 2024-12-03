variable "environment" {
  description = "Ambiente do cluster (dev, staging, prod)"
  type        = string
}

variable "cluster_name" {
  description = "Nome do cluster EKS"
  type        = string
}

variable "cluster_version" {
  description = "Versão do Kubernetes"
  type        = string
  default     = "1.27"
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs das subnets privadas"
  type        = list(string)
}

variable "security_group_ids" {
  description = "IDs dos security groups adicionais"
  type        = list(string)
  default     = []
}

# Variáveis para Service Account
variable "service_account_name" {
  description = "Nome da service account"
  type        = string
}

variable "namespace" {
  description = "Namespace do Kubernetes"
  type        = string
  default     = "default"
}

variable "region" {
  description = "Região AWS"
  type        = string
}

variable "account_id" {
  description = "ID da conta AWS"
  type        = string
}

variable "node_group_desired_size" {
  description = "Número desejado de nodes no EKS node group"
  type        = number
  default     = 2
}

variable "node_group_max_size" {
  description = "Número máximo de nodes no EKS node group"
  type        = number
  default     = 4
}

variable "node_group_min_size" {
  description = "Número mínimo de nodes no EKS node group"
  type        = number
  default     = 1
}
