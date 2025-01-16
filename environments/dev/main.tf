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
  cluster_version    = "1.31"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets
  security_group_ids = [module.security_groups.security_group_private_id]

  service_account_name = "dev-app-sa"
  namespace            = "default"
  region               = "us-east-1"
  account_id           = data.aws_caller_identity.current.account_id

  node_group_desired_size = 1
  node_group_max_size     = 3
  node_group_min_size     = 1
  # secrets_arn             = module.rds.secret_arn

  # sns_topic_arn                  = module.notifications.sns_topic_arn
  # sns_platform_application_arn   = module.notifications.platform_application_arn

  # athena_output_bucket = "s3://data-pipeline-caixa-s3/Athena/"
  # athena_input_bucket  = "s3://data-pipeline-caixa-s3/Athena/"
}

# resource "random_password" "postgresql_password" {
#   length           = 16
#   special          = false
#   override_special = "!#$%&*()-_=+[]{}<>:?"
#   min_special      = 0
#   min_upper        = 2
#   min_lower        = 2
#   min_numeric      = 2
# }

# module "rds" {
#   source = "../../modules/rds"
#   environment = "dev"
#   identifier        = "dev-postgresql"
#   engine_version    = "17.2"
#   instance_class    = "db.t3.small"
#   allocated_storage = 50

#   database_name     = "postgre"
#   database_username = "dbadmin"
#   database_password = random_password.postgresql_password.result

#   multi_az                = true
#   backup_retention_period = 30

#   vpc_id                     = module.vpc.vpc_id
#   subnet_ids                 = module.vpc.database_subnets
#   security_group_database_id = [module.security_groups.security_group_database_id]
#   enable_vector_mode = false  

#   tags = {
#     Environment = "dev"
#     Project     = "myapp"
#   }
# }


# module "scheduler" {
#   source = "../../modules/scheduler"

#   name_prefix        = "dev"
#   eks_cluster_name   = module.eks.cluster_id
#   rds_instance_name  = module.rds.instance_identifier
#   rds_cluster_name   = module.rds.instance_id
#   eks_nodegroup_name = module.eks.node_group_name

#   start_schedule = "cron(0 10 ? * * *)"
#   stop_schedule  = "cron(0 1 ? * * *)"

#   tags = {
#     Environment = "Development"
#     Project     = "ClusterScheduler"
#     Terraform   = "true"
#   }
# }

# module "notifications" {
#   source = "../../modules/notifications"

#   environment      = "dev"
#   application_name = "my-app"
#   fcm_server_key   = "AIzaSyCTSnY6m5dxjK_wtn8cuhQVUnZ9HDAbe8s"

#   oidc_provider_arn = module.eks.oidc_provider_arn
#   oidc_provider_url = module.eks.oidc_provider_url

#   k8s_namespace           = "notifications"
#   k8s_service_account_name = "notifications-service"

#   tags = {
#     Environment = "dev"
#     Service     = "notifications"
#   }
# }