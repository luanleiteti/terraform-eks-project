resource "aws_security_group" "main_sg_public_ssh" {
  name        = "${var.environment}-security-group-public-ssh"
  description = "Grupo de seguranca para SSH"
  vpc_id      = var.vpc_id

  ingress {
    description = "Permitir trafego de entrada SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Permitir todo o trafego de saida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-security-group-public-ssh"
  }
}

resource "aws_security_group" "main_sg_public_alb" {
  name        = "${var.environment}-security-group-public-alb"
  description = "Grupo de seguranca para ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "Permitir trafego de entrada HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Permitir trafego de entrada HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Permitir todo o trafego de saida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-security-group-public-alb"
  }
}

resource "aws_security_group" "main_sg_private" {
  name        = "${var.environment}-security-group-private"
  description = "Grupo de seguranca privado para instancias EC2"
  vpc_id      = var.vpc_id

  ingress {
    description     = "SSH do grupo de seguranca SSH publico"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.main_sg_public_ssh.id]
  }

  ingress {
    description     = "HTTP do ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.main_sg_public_alb.id]
  }

  ingress {
    description = "Todo o trafego das subredes privadas"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.private_subnets_cidr_blocks
  }

  egress {
    description = "Permitir todo trafego de saida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-security-group-private"
  }
}

resource "aws_security_group" "main_sg_database" {
  name        = "${var.environment}-security-group-database"
  description = "Grupo de seguranca para banco de dados"
  vpc_id      = var.vpc_id


  ingress {
    description     = "Permitir o trafego de entrada para portas de banco de dados postgres"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.main_sg_private.id]
  }

  egress {
    description = "Permitir todo o trafego de saida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-security-group-database"
  }
}
