# cloud-platform-terraform-aws-sso

This module maps Github users to the AWS web console via SAML and implements ABAC (Attribute-based access control) using resource tags.

## Usage

See the [examples/](examples/) folder.

To run `terraform apply`, the AWS account (numeric) ID and Auth0 tennant (name) must be passed, AWS profile set in local config and env vars `AUTH0_CLIENT_ID`, `AUTH0_CLIENT_SECRET`, `AUTH0_DOMAIN` exported, pointing to an app that has create privileges in the tenant (for us, it's the one called `terraform-provider-auth0`).

The [add groups](add-github-teams-to-saml-mappings.js) Auth0 rule needs 2 variables defined in its config, `AWS_ACCOUNT_ID` and `AWS_SAML_PROVIDER_NAME` (DNS name of the tenant).

This module sets the auth0 var `AWS_SAML_PROVIDER_NAME`, `AWS_ACCOUNT_ID` is also needed but for us it's already set in [global-resources/auth0.tf](https://github.com/ministryofjustice/cloud-platform-infrastructure/blob/main/terraform/global-resources/auth0.tf)

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_auth0"></a> [auth0](#requirement\_auth0) | >= 0.34.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.45.0 |
| <a name="requirement_curl"></a> [curl](#requirement\_curl) | >= 1.0.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_auth0"></a> [auth0](#provider\_auth0) | >= 0.34.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.45.0 |
| <a name="provider_curl"></a> [curl](#provider\_curl) | >= 1.0.2 |

## Modules

No modules.

## Resources



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auth0_tenant_domain"></a> [auth0\_tenant\_domain](#input\_auth0\_tenant\_domain) | Auth0 domain | `string` | n/a | yes |
| <a name="input_aws_callback_url"></a> [aws\_callback\_url](#input\_aws\_callback\_url) | AWS SSO callback URL | `string` | `"https://signin.aws.amazon.com/saml"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_saml_login_page"></a> [saml\_login\_page](#output\_saml\_login\_page) | n/a |

<!--- END_TF_DOCS --->

## Reading Material

https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_abac-saml.html
