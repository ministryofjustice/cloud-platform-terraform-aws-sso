data "aws_iam_policy_document" "sns_for_github" {
  statement {
    sid    = "AllowSNSListDescribe"
    effect = "Allow"
    actions = [
      "sns:ListPlatformApplications",
      "sns:ListSubscriptions",
      "sns:ListTagsForResource",
      "sns:ListTopics"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowSNSPublishOwn"
    effect = "Allow"
    actions = [
      "sns:Publish",
      "sns:GetPlatformApplicationAttributes",
      "sns:GetSubscriptionAttributes",
      "sns:GetTopicAttributes",
      "sns:GetEndpointAttributes",
      "sns:GetSubscriptionAttributes",
      "sns:Publish"
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }
}
