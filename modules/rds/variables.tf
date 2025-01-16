variable "identifier" {
  description = "Identificador único para a instância RDS"
  type        = string
}

variable "engine_version" {
  description = "Versão do PostgreSQL"
  type        = string
  default     = "14.7"
}

variable "instance_class" {
  description = "Tipo da instância RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Tamanho do storage em GB"
  type        = number
  default     = 20
}

variable "database_name" {
  description = "Nome do banco de dados"
  type        = string
}

variable "database_username" {
  description = "Username do banco de dados"
  type        = string
}

variable "database_password" {
  description = "Senha do banco de dados"
  type        = string
  sensitive   = true
}

variable "multi_az" {
  description = "Habilitar Multi-AZ"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Período de retenção do backup em dias"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Janela de backup preferencial"
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "Janela de manutenção preferencial"
  type        = string
  default     = "Mon:04:00-Mon:05:00"
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de IDs das subnets"
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  description = "Lista de CIDRs com acesso ao RDS"
  type        = list(string)
  default     = []
}

variable "allowed_security_groups" {
  description = "Lista de Security Groups com acesso ao RDS"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags para os recursos"
  type        = map(string)
  default     = {}
}

variable "security_group_database_id" {
  description = "Lista de IDs dos security groups"
  type        = list(string)
}

variable "enable_vector_mode" {
  description = "Whether to enable vector mode for PostgreSQL"
  type        = bool
  default     = false
}

variable "environment" {
  description = "Environment name (e.g., prod, staging, dev)"
  type        = string
}
