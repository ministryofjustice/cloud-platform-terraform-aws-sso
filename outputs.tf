output "saml_login_page" {
  value = "https://${var.auth0_tenant_domain}/samlp/${auth0_client.saml.client_id}?connection=github"
}

output "github_teams_filter_api_key" {
  value = aws_ssm_parameter.auth0_action_saml_mapping_filter_api_key.value
  sensitive = true
}
