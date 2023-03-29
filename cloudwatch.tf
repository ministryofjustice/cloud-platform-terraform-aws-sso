data "aws_iam_policy_document" "cloudwatch_for_github" {
  statement {
    sid    = "AllowList"
    effect = "Allow"
    actions = [
      "cloudwatch:ListMetric*",
      "cloudwatch:GetMetric*",
      "cloudwatch:ListDashboards"
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
