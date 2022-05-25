resource "auth0_client" "saml" {
  name        = "AWS SSO for ${data.aws_iam_account_alias.current.account_alias}"
  description = "Github SAML provider for the ${data.aws_iam_account_alias.current.account_alias} account"
  callbacks   = [var.aws_callback_url]
  logo_uri    = "https://ministryofjustice.github.io/assets/moj-crest.png"
  app_type    = "regular_web"
}
