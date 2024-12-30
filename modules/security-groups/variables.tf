variable "environment" {
  description = "Ambiente da infraestrutura (dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_subnets_cidr_blocks" {
  description = "Lista de IDs das subnets privadas"
  type        = list(string)
}