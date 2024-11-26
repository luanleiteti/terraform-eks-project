# VPC
output "vpc_id" {
  description = "O ID da VPC"
  value       = aws_vpc.main.id
}

output "vpc_arn" {
  description = "O ARN da VPC"
  value       = aws_vpc.main.arn
}

output "vpc_cidr_block" {
  description = "O bloco CIDR da VPC"
  value       = aws_vpc.main.cidr_block
}

# Subnets
output "public_subnets" {
  description = "Lista de IDs das subnets públicas"
  value       = aws_subnet.public[*].id
}

output "private_subnets" {
  description = "Lista de IDs das subnets privadas"
  value       = aws_subnet.private[*].id
}

output "database_subnets" {
  description = "Lista de IDs das subnets de banco de dados"
  value       = aws_subnet.database[*].id
}

# CIDR Blocks
output "public_subnet_cidr_blocks" {
  description = "Lista de blocos CIDR das subnets públicas"
  value       = aws_subnet.public[*].cidr_block
}

output "private_subnet_cidr_blocks" {
  description = "Lista de blocos CIDR das subnets privadas"
  value       = aws_subnet.private[*].cidr_block
}

output "database_subnet_cidr_blocks" {
  description = "Lista de blocos CIDR das subnets de banco de dados"
  value       = aws_subnet.database[*].cidr_block
}

# Gateways
output "nat_gateway_ids" {
  description = "Lista de IDs dos NAT Gateways"
  value       = aws_nat_gateway.main[*].id
}

output "internet_gateway_id" {
  description = "ID do Internet Gateway"
  value       = aws_internet_gateway.main.id
}

# Route Tables
output "public_route_table_ids" {
  description = "Lista de IDs das tabelas de roteamento públicas"
  value       = aws_route_table.public[*].id
}

output "private_route_table_ids" {
  description = "Lista de IDs das tabelas de roteamento privadas"
  value       = aws_route_table.private[*].id
}

output "database_route_table_ids" {
  description = "Lista de IDs das tabelas de roteamento do banco de dados"
  value       = aws_route_table.database[*].id
}

# # Network ACLs
# output "public_network_acl_id" {
#   description = "ID da Network ACL pública"
#   value       = aws_network_acl.public.id
# }

# output "private_network_acl_id" {
#   description = "ID da Network ACL privada"
#   value       = aws_network_acl.private.id
# }

# output "database_network_acl_id" {
#   description = "ID da Network ACL do banco de dados"
#   value       = aws_network_acl.database.id
# }
