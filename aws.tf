data "curl" "saml_metadata" {
  http_method = "GET"
  uri = "https://${var.auth0_tenant_domain}/samlp/metadata/${auth0_client.saml.client_id}"
}

resource "aws_iam_saml_provider" "auth0" {
  name                   = var.auth0_tenant_domain
  saml_metadata_document = data.curl.saml_metadata.response
}

data "aws_iam_policy_document" "federated_role_trust_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_saml_provider.auth0.arn]
    }

    actions = ["sts:AssumeRoleWithSAML","sts:SetSourceIdentity","sts:TagSession"]

    condition {
      test     = "StringEquals"
      variable = "SAML:aud"
      values   = ["https://signin.aws.amazon.com/saml"]
    }
    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/GithubTeam"
      values   = ["*"]
    }

  }
}

resource "aws_iam_role" "github_access" {
  name = "access-via-github"
  assume_role_policy   = data.aws_iam_policy_document.federated_role_trust_policy.json
  max_session_duration = 10 * 3600
}
