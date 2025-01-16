variable "environment" {
  description = "Ambiente da infraestrutura (dev, staging, prod)"
  type        = string
}

variable "tags" {
  description = "Tags adicionais para recursos"
  type        = map(string)
  default     = {}
} 