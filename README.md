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

| Name | Type |
|------|------|
| [auth0_client.saml](https://registry.terraform.io/providers/auth0/auth0/latest/docs/resources/client) | resource |
| [auth0_rule.saml_mappings](https://registry.terraform.io/providers/auth0/auth0/latest/docs/resources/rule) | resource |
| [auth0_rule_config.aws_saml_provider_name](https://registry.terraform.io/providers/auth0/auth0/latest/docs/resources/rule_config) | resource |
| [aws_iam_policy.api_gateway_for_github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.github_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.github_access_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.github_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.api_gateway_for_github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.github_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_saml_provider.auth0](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_saml_provider) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_account_alias.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_account_alias) | data source |
| [aws_iam_policy_document.api_gateway_for_github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch_for_github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cognito_idp_for_github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.combined](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.combined_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.elasticache_for_github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.federated_role_trust_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.iam_for_github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.kms_for_github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.opensearch_for_github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pi_for_github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.rds_for_github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_for_github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.secretsmanager_for_github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns_for_github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sqs_for_github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.vpc_for_github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [curl_curl.saml_metadata](https://registry.terraform.io/providers/anschoewe/curl/latest/docs/data-sources/curl) | data source |

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
