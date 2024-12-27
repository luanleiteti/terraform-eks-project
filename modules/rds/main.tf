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
  multi_az           = var.multi_az
  publicly_accessible = false
  
  # Backup e manutenção
  backup_retention_period = var.backup_retention_period
  backup_window          = var.backup_window
  maintenance_window     = var.maintenance_window
  
  # Networking
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.rds.i]

  # Monitoramento
  monitoring_interval = 60
  monitoring_role_arn = aws_iam_role.rds_monitoring.arn
  
  # Parâmetros de segurança
  parameter_group_name = aws_db_parameter_group.postgresql.name

  deletion_protection = true

  tags = var.tags
}
