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

resource "aws_iam_policy" "api_gateway_for_github" {
  policy = data.aws_iam_policy_document.api_gateway_for_github.json
  name   = "api-gateway-for-github"
  tags = {
    GithubTeam = "webops"
  }
}

resource "aws_iam_role_policy_attachment" "api_gateway_for_github" {
  role       = aws_iam_role.github_access.name
  policy_arn = aws_iam_policy.api_gateway_for_github.arn
}
