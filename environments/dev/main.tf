data "aws_caller_identity" "current" {}

module "vpc" {
  source      = "../../modules/vpc"
  environment = "dev"
}

module "security_groups" {
  source                      = "../../modules/security-groups"
  environment                 = "dev"
  vpc_id                      = module.vpc.vpc_id
  private_subnets_cidr_blocks = module.vpc.private_subnet_cidr_blocks
}

module "eks" {
  source = "../../modules/eks"

  environment        = "dev"
  cluster_name       = "dev-eks-cluster"
  cluster_version    = "1.27"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets
  security_group_ids = [module.security_groups.security_group_private_id]

  service_account_name = "dev-app-sa"
  namespace            = "default"
  region               = "us-east-1"
  account_id           = data.aws_caller_identity.current.account_id

  node_group_desired_size = 2
  node_group_max_size     = 4
  node_group_min_size     = 1
}

resource "random_password" "postgresql_password" {
  length           = 16
  special          = false
  override_special = "!#$%&*()-_=+[]{}<>:?"
  min_special      = 0
  min_upper        = 2
  min_lower        = 2
  min_numeric      = 2
}

module "postgresql" {
  source = "../../modules/rds"

  identifier        = "prod-postgresql"
  engine_version    = "14.7"
  instance_class    = "db.t3.small"
  allocated_storage = 50

  database_name     = "myapp"
  database_username = "dbadmin"
  database_password = random_password.postgresql_password.result

  multi_az                = true
  backup_retention_period = 30

  vpc_id                     = module.vpc.vpc_id
  subnet_ids                 = module.vpc.private_subnets
  security_group_database_id = [module.security_groups.security_group_database_id]

  tags = {
    Environment = "prod"
    Project     = "myapp"
  }
}