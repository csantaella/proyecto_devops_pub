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
  region  = "eu-west-1"
}
