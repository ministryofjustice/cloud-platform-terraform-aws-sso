data "aws_iam_policy_document" "iam_for_github" {

  statement {
    sid    = "AllowListDescribe"
    effect = "Allow"
    actions = [
      "iam:ListRoles",
      "iam:ListPolicies",
      "kms:List*",
      "kms:Describe*"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowGetOwn"
    effect = "Allow"
    actions = [
      "iam:Get*",
      "iam:List*",
      "kms:Get*"
    ]
    resources = ["*"]
    condition {
     test = "StringLike"
     variable = "aws:PrincipalTag/GithubTeam"
     values = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }

}

resource "aws_iam_policy" "iam_for_github" {
  policy = data.aws_iam_policy_document.iam_for_github.json
  name = "iam-for-github"
  tags = {
    GithubTeam = "webops"
  }
}

resource "aws_iam_role_policy_attachment" "iam_for_github" {
  role       = aws_iam_role.github_access.name
  policy_arn = aws_iam_policy.iam_for_github.arn
}
