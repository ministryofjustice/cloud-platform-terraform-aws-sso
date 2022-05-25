terraform {
  required_providers {
    auth0 = {
      source  = "auth0/auth0"
    }
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 0.14"
}
