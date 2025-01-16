resource "aws_db_parameter_group" "postgresql" {
  count = var.enable_vector_mode ? 0 : 1
  name   = "${var.environment}-postgresql-pg"
  family = "postgres17"

  parameter {
    name  = "log_connections"
    value = "1"
  }

  parameter {
    name  = "log_disconnections"
    value = "1"
  }

  parameter {
    name  = "log_statement"
    value = "all"
  }

  parameter {
    name         = "max_connections"
    value        = "100"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "shared_buffers"
    value        = "{DBInstanceClassMemory/32768}"
    apply_method = "pending-reboot"
  }

  tags = var.tags
} 

resource "aws_db_parameter_group" "postgresql_vector" {
  count = var.enable_vector_mode ? 1 : 0
  
  family = "postgres15"
  name   = "${var.environment}-postgresql-vector"
  description = "Grupo de parâmetros para configuração do PostgreSQL habilitado para vetor"

  # Otimizações básicas de memória
  parameter {
    name         = "shared_buffers"
    value        = "32768"  # 32MB
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "max_connections"
    value        = "100"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "maintenance_work_mem"
    value        = "64000"  # 64MB
    apply_method = "pending-reboot"
  }

  lifecycle {
    ignore_changes = all
  }

  tags = var.tags
}
