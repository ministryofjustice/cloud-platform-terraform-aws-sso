provider "auth0" {
  domain = var.auth0_tenant_domain
}

resource "auth0_client" "saml" {
  name        = "AWS SSO for ${data.aws_iam_account_alias.current.account_alias}"
  description = "Github SAML provider for the ${data.aws_iam_account_alias.current.account_alias} account"
  callbacks   = [var.aws_callback_url]
  logo_uri    = "https://ministryofjustice.github.io/assets/moj-crest.png"
  app_type    = "regular_web"

  addons {
    samlp {
      audience = var.aws_callback_url
      mappings = {
        email = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
        name  = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
      }
      create_upn_claim                   = false
      passthrough_claims_with_no_mapping = false
      map_unknown_claims_as_is           = false
      map_identities                     = false
      name_identifier_format             = "urn:oasis:names:tc:SAML:2.0:nameid-format:persistent"
      name_identifier_probes             = ["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"]
      signing_cert                       = "pemcertificate"
      lifetime_in_seconds                = 36000
    }
  }

}

resource "auth0_action" "saml_mappings" {
  name = "add-github-teams-to-aws-saml"
  code = file(
    "${path.module}/add-github-teams-to-aws-saml.js",
  )
  deploy  = true
  runtime = "node18"

  supported_triggers {
    id      = "post-login"
    version = "v3"
  }

    dependencies {
    name    = "axios"
    version = "1.7.7"
  }

  secrets {
    name  = "AWS_SAML_PROVIDER_NAME"
    value = var.auth0_tenant_domain
  }

  secrets {
    name  = "AWS_ACCOUNT_ID"
    value = data.aws_caller_identity.current.account_id
  }

  secrets {
    name = "FILTER_API_KEY"
    value = aws_ssm_parameter.auth0_action_saml_mapping_filter_api_key.value
  }
}

resource "aws_ssm_parameter" "auth0_action_saml_mapping_filter_api_key" {
  name  = "/auth0/${var.auth0_tenant_domain}/action/saml_mappings/filter_api_key"
  type  = "String"
  value = "dummy-value"

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
