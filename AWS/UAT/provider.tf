terraform {
  required_version = ">= 1.4.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  access_key = local.AWS_ACCESS_KEY_ID
  secret_key = local.AWS_SECRET_ACCESS_KEY
  region     = local.region
  #token      = local.AWS_SESSION_TOKEN
}