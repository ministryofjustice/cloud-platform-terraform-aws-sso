data "aws_iam_policy_document" "opensearch_for_github" {
  statement {
    sid    = "AllowListDescribe"
    effect = "Allow"
    actions = [
      "es:DescribeDomain",
      "es:ListDomainNames",
      "es:ListTags"
    ]
    resources = ["*"]
  }
}
