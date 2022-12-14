provider "aws" {
  region  = "eu-west-2"
  profile = "moj-cp"
}

module "sso" {
  source = "../"

  auth0_tenant_domain = "test.eu.auth0.com"
}
