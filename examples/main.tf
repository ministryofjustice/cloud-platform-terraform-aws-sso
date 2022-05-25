provider "aws" {
  region  = "eu-west-2"
  profile = "moj-cp"
}

module "sso" {
  source = "../"

  aws_account_id = "1234567890"
}
