resource "aws_secretsmanager_secret" "rds_credentials" {
  name = "rds/${var.identifier}/credentials-${formatdate("YYYYMMDD-HHmmss", timestamp())}"
  tags = var.tags

  lifecycle {
    ignore_changes = all
  }
}

resource "aws_secretsmanager_secret_version" "rds_credentials" {
  secret_id = aws_secretsmanager_secret.rds_credentials.id
  secret_string = jsonencode({
    username = var.database_username
    password = var.database_password
    engine   = "postgresql"
    host     = aws_db_instance.postgresql.address
    port     = aws_db_instance.postgresql.port
    dbname   = var.database_name
  })

  lifecycle {
    ignore_changes = all
  }
}
