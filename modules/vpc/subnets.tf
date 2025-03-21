# Subnets Públicas
resource "aws_subnet" "public" {
  count                   = length(local.public_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.public_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name                     = "${var.environment}-public-subnet-${count.index + 1}"
      Environment             = var.environment
      "kubernetes.io/role/elb" = "1"
      "kubernetes.io/cluster/${var.environment}-eks-cluster" = "shared"
    },
    var.tags
  )
}

# Subnets Privadas
resource "aws_subnet" "private" {
  count             = length(local.private_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.private_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    {
      Name                              = "${var.environment}-private-subnet-${count.index + 1}"
      Environment                       = var.environment
      "kubernetes.io/role/internal-elb" = "1"
      "kubernetes.io/cluster/${var.environment}-eks-cluster" = "shared"
    },
    var.tags
  )
}

# Subnets para Banco de Dados
resource "aws_subnet" "database" {
  count             = length(local.database_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.database_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    {
      Name        = "${var.environment}-database-subnet-${count.index + 1}"
      Environment = var.environment
    },
    var.tags
  )
}
