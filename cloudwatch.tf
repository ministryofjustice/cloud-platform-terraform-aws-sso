data "aws_iam_policy_document" "cloudwatch_for_github" {

  statement {
    sid    = "AllowList"
    effect = "Allow"
    actions = [
      "cloudwatch:ListMetric*",
      "cloudwatch:GetMetric*"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowViewOwn"
    effect = "Allow"
    actions = [
      "cloudwatch:GetDashboard"
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }

}

resource "aws_iam_policy" "cloudwatch_for_github" {
  policy = data.aws_iam_policy_document.cloudwatch_for_github.json
  name   = "cloudwatch-for-github"
  tags = {
    GithubTeam = "webops"
  }
}

resource "aws_iam_role_policy_attachment" "cloudwatch_for_github" {
  role       = aws_iam_role.github_access.name
  policy_arn = aws_iam_policy.cloudwatch_for_github.arn
}
