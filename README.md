# cloud-platform-terraform-aws-sso

This module maps Github users to the AWS web console via SAML and implements ABAC (Attribute-based access control) using resource tags.

## Usage

See the [examples/](examples/) folder.

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

## Modules

No Modules.

## Resources

| Name |
|------|
| [auth0_client](https://registry.terraform.io/providers/alexkappa/auth0/latest/docs/resources/client) |
| [aws_caller_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) |
| [aws_iam_account_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_account_alias) |
| [aws_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_account\_id | The AWS Account numeric ID | `string` | n/a | yes |
| aws\_callback\_url | AWS SSO callback URL | `string` | `"https://signin.aws.amazon.com/saml"` | no |

## Outputs

No output.

<!--- END_TF_DOCS --->

## Reading Material

https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_abac-saml.html
