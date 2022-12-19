terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.37.0"
    }
    auth0 = {
      source  = "auth0/auth0"
      version = "0.39.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "auth0" {
  domain        = var.auth0_domain
  client_id     = var.auth0_clientID
  client_secret = var.auth0_client_secret
  debug         = var.auth0_debug
}