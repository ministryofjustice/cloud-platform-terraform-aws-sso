data "aws_iam_policy_document" "opensearch_for_github" {
  statement {
    sid    = "AllowOpenSearchListDescribe"
    effect = "Allow"
    actions = [
      "es:DescribeDomain",
      "es:ListDomainNames",
      "es:ListTags"
    ]
    resources = ["*"]
  }
}
