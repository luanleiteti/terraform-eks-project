locals {
  vpc_cidr_blocks = {
    dev = {
      vpc_cidr = "10.0.0.0/16"
      public_subnets = [
        "10.0.10.0/24",
        "10.0.20.0/24",
        "10.0.30.0/24"
      ]
      private_subnets = [
        "10.0.40.0/24",
        "10.0.50.0/24",
        "10.0.60.0/24"
      ]
      database_subnets = [
        "10.0.70.0/24",
        "10.0.80.0/24",
        "10.0.90.0/24"
      ]
    }
    staging = {
      vpc_cidr = "172.16.0.0/16"
      public_subnets = [
        "172.16.10.0/24",
        "172.16.20.0/24",
        "172.16.30.0/24"
      ]
      private_subnets = [
        "172.16.40.0/24",
        "172.16.50.0/24",
        "172.16.60.0/24"
      ]
      database_subnets = [
        "172.16.70.0/24",
        "172.16.80.0/24",
        "172.16.90.0/24"
      ]
    }
    prod = {
      vpc_cidr = "192.168.0.0/16"
      public_subnets = [
        "192.168.10.0/24",
        "192.168.20.0/24",
        "192.168.30.0/24"
      ]
      private_subnets = [
        "192.168.40.0/24",
        "192.168.50.0/24",
        "192.168.60.0/24"
      ]
      database_subnets = [
        "192.168.70.0/24",
        "192.168.80.0/24",
        "192.168.90.0/24"
      ]
    }
  }

  # Lookup values baseado no ambiente
  vpc_cidr       = local.vpc_cidr_blocks[var.environment].vpc_cidr
  public_cidrs   = local.vpc_cidr_blocks[var.environment].public_subnets
  private_cidrs  = local.vpc_cidr_blocks[var.environment].private_subnets
  database_cidrs = local.vpc_cidr_blocks[var.environment].database_subnets
} 