data "http" "metadata" {
  url = "https://${var.auth0_tenant_domain}/samlp/metadata/${auth0_client.saml.client_id}"
}

resource "aws_iam_saml_provider" "auth0" {
  name                   = var.auth0_tenant_domain
  saml_metadata_document = data.http.metadata.body
}
