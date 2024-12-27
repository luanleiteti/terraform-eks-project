resource "aws_db_parameter_group" "postgresql" {
  family = "postgres${split(".", var.engine_version)[0]}"
  name   = "${var.identifier}-pg"

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
    name  = "ssl"
    value = "1"
  }

  tags = var.tags
} 