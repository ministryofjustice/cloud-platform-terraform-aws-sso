data "aws_iam_policy_document" "ses_for_github" {
  statement {
    sid     = "AllowSESListDescribe"
    effect  = "Allow"

    actions = [
      "ses:GetAccount",
      "ses:ListReceiptRuleSets",
      "ses:DescribeActiveReceiptRuleSet",
      "ses:DescribeConfigurationSet",
      "ses:DescribeReceiptRule",
      "ses:DescribeReceiptRuleSet"
    ]

    resources = ["*"]
  }
}
