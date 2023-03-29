data "aws_iam_policy_document" "cognito_idp_for_github" {
  statement {
    sid    = "AllowList"
    effect = "Allow"
    actions = [
      "cognito-idp:ListUserPools"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowGetOwn"
    effect = "Allow"
    actions = [
      "cognito-idp:List*",
      "cognito-idp:Describe*",
      "cognito-idp:Get*"
    ]
    resources = [
      "arn:aws:cognito-idp:*:${data.aws_caller_identity.current.account_id}:userpool/*",
      "arn:aws:wafv2:*:${data.aws_caller_identity.current.account_id}:*/webacl/*/*"
    ]

    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }
}

resource "aws_iam_policy" "cognito_idp_for_github" {
  policy = data.aws_iam_policy_document.cognito_idp_for_github.json
  name   = "cognito-idp-for-github"
  tags = {
    GithubTeam = "webops"
  }
}

resource "aws_iam_role_policy_attachment" "cognito_idp_for_github" {
  role       = aws_iam_role.github_access.name
  policy_arn = aws_iam_policy.cognito_idp_for_github.arn
}
