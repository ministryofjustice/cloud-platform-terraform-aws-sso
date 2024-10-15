data "aws_iam_policy_document" "mq_for_github" {
  statement {
    sid    = "AllowMQListDescribe"
    effect = "Allow"
    actions = [
      "mq:DescribeBroker",
      "mq:DescribeConfiguration",
      "mq:DescribeConfigurationRevision",
      "mq:ListBrokers",
      "mq:ListConfigurationRevisions",
      "mq:ListConfigurations",
      "mq:ListTags"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowMQGetOwn"
    effect = "Allow"
    actions = [
      "mq:DescribeBroker",
      "mq:DescribeConfiguration",
      "mq:DescribeConfigurationRevision",
      "mq:ListBrokers",
      "mq:ListConfigurationRevisions",
      "mq:ListConfigurations",
      "mq:ListTags",
      "mq:ListUsers",
      "mq:DescribeUser"

    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }
}