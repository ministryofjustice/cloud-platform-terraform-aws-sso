data "aws_iam_policy_document" "api_gateway_for_github" {
  statement {
    sid       = "AllowGetOwn"
    effect    = "Allow"
    actions   = ["apigateway:GET"]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }
}
