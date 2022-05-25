terraform {
  required_providers {
    auth0 = {
      source = "auth0/auth0"
    }
    aws = {
      source = "hashicorp/aws"
    }
    curl = {
      source  = "anschoewe/curl"
    }
  }
  required_version = ">= 0.14"
}
