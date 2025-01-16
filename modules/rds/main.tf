resource "aws_db_instance" "postgresql" {
  identifier        = var.identifier
  engine            = "postgres"
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage

  db_name  = var.database_name
  username = var.database_username
  password = var.database_password

  # Configurações de segurança
  storage_encrypted   = true
  multi_az            = var.multi_az
  publicly_accessible = false

  # Backup e manutenção
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  # Networking
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.security_group_database_id

  # Monitoramento
  monitoring_interval = 60
  monitoring_role_arn = aws_iam_role.rds_monitoring.arn

  # Parâmetros
  parameter_group_name = var.enable_vector_mode ? aws_db_parameter_group.postgresql_vector[0].name : aws_db_parameter_group.postgresql[0].name

  deletion_protection = true
  skip_final_snapshot = true

  # Desabilitar otimização de armazenamento
  storage_type = "gp3"

  tags = var.tags
}

resource "postgresql_extension" "pgvector" {
  count    = var.enable_vector_mode ? 1 : 0
  name     = "vector"
  database = aws_db_instance.postgresql.db_name

  depends_on = [aws_db_instance.postgresql]
}

