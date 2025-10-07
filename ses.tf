data "aws_iam_policy_document" "ses_for_github" {
  statement {
    sid     = "AllowSESGetOwn"
    effect  = "Allow"
    actions = [
      "ses:GetAccountSendingEnabled",
      "ses:GetCustomVerificationEmailTemplate",
      "ses:GetIdentityDkimAttributes",
      "ses:GetIdentityMailFromDomainAttributes",
      "ses:GetIdentityNotificationAttributes",
      "ses:GetIdentityPolicies",
      "ses:GetIdentityVerificationAttributes",
      "ses:GetSendQuota",
      "ses:GetSendStatistics",
      "ses:GetTemplate",
      "ses:ListConfigurationSets",
      "ses:ListCustomVerificationEmailTemplates",
      "ses:ListIdentities",
      "ses:ListIdentityPolicies",
      "ses:ListReceiptFilters",
      "ses:ListReceiptRuleSets",
      "ses:ListTemplates",
      "ses:ListVerifiedEmailAddresses",
      "ses:DescribeActiveReceiptRuleSet",
      "ses:DescribeConfigurationSet",
      "ses:DescribeReceiptRule",
      "ses:DescribeReceiptRuleSet"
    ]

    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }
}
