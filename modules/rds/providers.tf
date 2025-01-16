terraform {
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "~> 1.0"
    }
  }
}

provider "postgresql" {
  host            = aws_db_instance.postgresql.address
  port            = aws_db_instance.postgresql.port
  database        = var.database_name
  username        = var.database_username
  password        = var.database_password
  sslmode         = "require"
  connect_timeout = 15
} 