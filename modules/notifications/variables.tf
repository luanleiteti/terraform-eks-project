variable "environment" {
  description = "Ambiente (dev, staging, prod)"
  type        = string
}

variable "application_name" {
  description = "Nome da aplicação"
  type        = string
}

variable "fcm_server_key" {
  description = "Chave do servidor FCM (Firebase Cloud Messaging)"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags para os recursos"
  type        = map(string)
  default     = {}
}

variable "oidc_provider_arn" {
  description = "ARN do provedor OIDC do EKS"
  type        = string
}

variable "oidc_provider_url" {
  description = "URL do provedor OIDC do EKS"
  type        = string
}

variable "k8s_namespace" {
  description = "Namespace Kubernetes para o serviço de notificações"
  type        = string
  default     = "notifications"
}

variable "k8s_service_account_name" {
  description = "Nome da Service Account Kubernetes"
  type        = string
  default     = "notifications-service"
} 