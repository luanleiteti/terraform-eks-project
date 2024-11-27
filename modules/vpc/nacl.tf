# NACL para subnets do banco de dados
resource "aws_network_acl" "database" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.database[*].id

  tags = {
    Name        = "${var.environment}-database-nacl"
    Environment = var.environment
  }
}

# Regra de entrada - permite tráfego PostgreSQL (porta 5432)
resource "aws_network_acl_rule" "database_inbound_postgresql" {
  network_acl_id = aws_network_acl.database.id
  rule_number    = 100
  protocol       = "tcp"
  rule_action    = "allow"
  egress         = false
  cidr_block     = local.vpc_cidr
  from_port      = 5432
  to_port        = 5432
}

# Regra de saída - permite tráfego de retorno
resource "aws_network_acl_rule" "database_outbound_ephemeral" {
  network_acl_id = aws_network_acl.database.id
  rule_number    = 100
  protocol       = "tcp"
  rule_action    = "allow"
  egress         = true
  cidr_block     = local.vpc_cidr
  from_port      = 1024
  to_port        = 65535
}
