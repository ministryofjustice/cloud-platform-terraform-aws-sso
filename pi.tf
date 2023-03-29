data "aws_iam_policy_document" "pi_for_github" {
  statement {
    sid    = "AllowPerformanceInsights"
    effect = "Allow"
    actions = [
      "pi:*",
    ]
    resources = ["*"]
  }
}
