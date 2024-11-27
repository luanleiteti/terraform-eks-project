terraform {
  backend "s3" {
    bucket  = "project-eks-terraform-s3"
    key     = "eks-terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    # dynamodb_table = "terraform-state-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}
