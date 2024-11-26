locals {
  
  queue = {
    "0" = {
      cidr_block  = local.private_subnet[0]
      rule_number = 100
    }

    "1" = {
      cidr_block  = local.private_subnet[1]
      rule_number = 200
    }

    "2" = {
      cidr_block  = local.private_subnet[2]
      rule_number = 300
    }
  }
}