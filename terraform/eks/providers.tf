terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version =  "~> 5.36.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
