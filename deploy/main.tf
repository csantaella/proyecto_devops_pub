terraform {
  backend "s3" {
    bucket         = "csantaella-proyecto-devops-tfstate"
    key            = "app.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "csantaella-db-proyecto-devops-tfstate"
  }
}

provider "aws" {
  region = "eu-west-1"
}

locals {
  prefix = "${var.prefix}-${terraform.workspace}"
  common_tags = {
    Environment = terraform.workspace
    Project     = var.project
    Owner       = var.contact
    ManagedBy   = "Terraform"
  }
}

data "aws_region" "current" {}
