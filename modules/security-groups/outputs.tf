output "security_group_public_ssh_id" {
  description = "ID do security group público para SSH"
  value       = aws_security_group.main_sg_public_ssh.id
}

output "security_group_public_ssh_name" {
  description = "Nome do security group público para SSH"
  value       = aws_security_group.main_sg_public_ssh.name
}

output "security_group_public_alb_id" {
  description = "ID do security group público para ALB"
  value       = aws_security_group.main_sg_public_alb.id
}

output "security_group_public_alb_name" {
  description = "Nome do security group público para ALB"
  value       = aws_security_group.main_sg_public_alb.name
}

output "security_group_private_id" {
  description = "ID do security group privado"
  value       = aws_security_group.main_sg_private.id
}

output "security_group_private_name" {
  description = "Nome do security group privado"
  value       = aws_security_group.main_sg_private.name
}

output "security_group_private_arn" {
  description = "ARN do security group privado"
  value       = aws_security_group.main_sg_private.arn
}

output "security_group_public_alb_arn" {
  description = "ARN do security group público para ALB"
  value       = aws_security_group.main_sg_public_alb.arn
}

output "security_group_public_ssh_arn" {
  description = "ARN do security group público para SSH"
  value       = aws_security_group.main_sg_public_ssh.arn
}
