# -- provider.tf (Provider) -- #

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


provider "aws" {
  region     = var.aws_region
  access_key = "xxxx"
  secret_key = "bo+xxxxx+xxx"
}