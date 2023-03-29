data "aws_iam_policy_document" "cloudwatch_for_github" {
  statement {
    sid    = "AllowCloudwatchList"
    effect = "Allow"
    actions = [
      "cloudwatch:ListMetric*",
      "cloudwatch:GetMetric*",
      "cloudwatch:ListDashboards"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowCloudwatchViewOwn"
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
