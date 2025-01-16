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

variable "secrets_arn" {
  description = "ARN do Secrets Manager"
  type        = string
  default     = null
}

variable "sns_topic_arn" {
  description = "ARN do tópico SNS para notificações"
  type        = string
  default     = null
}

variable "sns_platform_application_arn" {
  description = "ARN da aplicação de plataforma SNS (Android/FCM)"
  type        = string
  default     = null
}

variable "athena_output_bucket" {
  description = "Nome do bucket S3 para output do Athena"
  type        = string
}

variable "athena_input_bucket" {
  description = "Nome do bucket S3 para input do Athena"
  type        = string
}
