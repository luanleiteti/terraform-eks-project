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

  ingress {
    description = "Kubelet API"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    self        = true
  }

  ingress {
    description = "Comunicacao entre nos do cluster"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true
  }

  ingress {
    description = "Metrics Server"
    from_port   = 4443
    to_port     = 4443
    protocol    = "tcp"
    self        = true
  }

  ingress {
    description = "CoreDNS"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    self        = true
  }

  ingress {
    description = "HTTP from Load Balancer"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    security_groups = [aws_security_group.main_sg_public_alb.id]
  }

  ingress {
    description = "NGINX Ingress Health Checks"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    security_groups = [aws_security_group.main_sg_public_alb.id]
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
    security_groups = concat([aws_security_group.main_sg_private.id], var.additional_database_security_groups)
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
