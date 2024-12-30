# Informações da Instância
output "instance_id" {
  description = "ID da instância RDS"
  value       = aws_db_instance.postgresql.id
}

output "instance_arn" {
  description = "ARN da instância RDS"
  value       = aws_db_instance.postgresql.arn
}

output "instance_status" {
  description = "Status atual da instância RDS"
  value       = aws_db_instance.postgresql.status
}

# Informações de Conexão
output "endpoint" {
  description = "Endpoint de conexão da instância RDS"
  value       = aws_db_instance.postgresql.endpoint
}

output "port" {
  description = "Porta de conexão do PostgreSQL"
  value       = aws_db_instance.postgresql.port
}

output "database_name" {
  description = "Nome do banco de dados"
  value       = aws_db_instance.postgresql.db_name
}

output "username" {
  description = "Username master do banco de dados"
  value       = aws_db_instance.postgresql.username
}

# Informações de Rede
output "subnet_group_id" {
  description = "ID do subnet group do RDS"
  value       = aws_db_subnet_group.this.id
}

output "subnet_group_arn" {
  description = "ARN do subnet group do RDS"
  value       = aws_db_subnet_group.this.arn
}

# Informações de Monitoramento
output "monitoring_role_arn" {
  description = "ARN da role de monitoramento"
  value       = aws_iam_role.rds_monitoring.arn
}

output "parameter_group_id" {
  description = "ID do parameter group"
  value       = aws_db_parameter_group.postgresql.id
}

# Informações de Backup
output "backup_retention_period" {
  description = "Período de retenção do backup em dias"
  value       = aws_db_instance.postgresql.backup_retention_period
}

output "backup_window" {
  description = "Janela de backup preferencial"
  value       = aws_db_instance.postgresql.backup_window
}

output "maintenance_window" {
  description = "Janela de manutenção preferencial"
  value       = aws_db_instance.postgresql.maintenance_window
}

# String de conexão (exemplo para aplicações)
output "connection_string" {
  description = "String de conexão PostgreSQL (sem senha)"
  value       = "postgresql://${aws_db_instance.postgresql.username}@${aws_db_instance.postgresql.endpoint}/${aws_db_instance.postgresql.db_name}"
}

# Informações de Performance
output "allocated_storage" {
  description = "Storage alocado em GB"
  value       = aws_db_instance.postgresql.allocated_storage
}

output "instance_class" {
  description = "Tipo da instância RDS"
  value       = aws_db_instance.postgresql.instance_class
}

output "engine_version" {
  description = "Versão do PostgreSQL"
  value       = aws_db_instance.postgresql.engine_version
} 