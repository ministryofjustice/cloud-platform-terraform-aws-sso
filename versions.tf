terraform {
  required_providers {
    auth0 = {
      source  = "auth0/auth0"
      version = ">=0.34.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.45.0"
    }
    curl = {
      source  = "anschoewe/curl"
      version = ">=1.0.2"
    }
  }
  required_version = ">= 1.2.5"
}
