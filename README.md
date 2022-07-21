# cloud-platform-terraform-aws-sso

This module maps Github users to the AWS web console via SAML and implements ABAC (Attribute-based access control) using resource tags.

## Usage

See the [examples/](examples/) folder.

To run `terraform apply`, the AWS account (numeric) ID and Auth0 tennant (name) must be passed, AWS profile set in local config and env vars `AUTH0_CLIENT_ID`, `AUTH0_CLIENT_SECRET`, `AUTH0_DOMAIN` exported, pointing to an app that has create privileges in the tenant (for us, it's the one called `terraform-provider-auth0`).

The [add groups](add-github-teams-to-saml-mappings.js) Auth0 rule needs 2 variables defined in its config, `AWS_ACCOUNT_ID` and `AWS_SAML_PROVIDER_NAME` (DNS name of the tenant).

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14 |

## Providers

| Name | Version |
|------|---------|
| auth0 | n/a |
| aws | n/a |
| curl | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [auth0_client](https://registry.terraform.io/providers/auth0/auth0/latest/docs/resources/client) |
| [auth0_rule](https://registry.terraform.io/providers/auth0/auth0/latest/docs/resources/rule) |
| [aws_caller_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) |
| [aws_iam_account_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_account_alias) |
| [aws_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) |
| [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) |
| [aws_iam_saml_provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_saml_provider) |
| [aws_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) |
| [curl_curl](https://registry.terraform.io/providers/anschoewe/curl/latest/docs/data-sources/curl) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| auth0\_tenant\_domain | Auth0 domain | `string` | n/a | yes |
| aws\_account\_id | The AWS Account numeric ID | `string` | n/a | yes |
| aws\_callback\_url | AWS SSO callback URL | `string` | `"https://signin.aws.amazon.com/saml"` | no |

## Outputs

| Name | Description |
|------|-------------|
| saml\_login\_page | n/a |

<!--- END_TF_DOCS --->

## Reading Material

https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_abac-saml.html
