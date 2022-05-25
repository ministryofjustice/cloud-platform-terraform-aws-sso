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
| aws | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_caller_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) |
| [aws_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) |

## Inputs

No input.

## Outputs

No output.

<!--- END_TF_DOCS --->

## Reading Material

https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_abac-saml.html
