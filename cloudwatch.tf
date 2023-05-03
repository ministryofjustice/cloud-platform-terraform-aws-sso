data "aws_iam_policy_document" "cloudwatch_for_github" {
  statement {
    sid    = "AllowCloudwatchList"
    effect = "Allow"
    actions = [
      "cloudwatch:ListMetric*",
      "cloudwatch:GetMetric*",
      "cloudwatch:ListDashboards",
      "logs:DescribeLogGroups",
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowCloudwatchViewOwn"
    effect = "Allow"
    actions = [
      "cloudwatch:GetDashboard",
      "logs:ListTagsLogGroup",
      "logs:DescribeQueries",
      "logs:GetLogRecord",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:DescribeSubscriptionFilters",
      "logs:StartQuery",
      "logs:DescribeMetricFilters",
      "logs:StopQuery",
      "logs:TestMetricFilter",
      "logs:GetLogDelivery",
      "logs:ListTagsForResource",
      "logs:ListLogDeliveries",
      "logs:DescribeExportTasks",
      "logs:GetQueryResults",
      "logs:GetLogEvents",
      "logs:FilterLogEvents",
      "logs:DescribeQueryDefinitions",
      "logs:GetLogGroupFields",
      "logs:DescribeResourcePolicies",
      "logs:DescribeDestinations"
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }
}
