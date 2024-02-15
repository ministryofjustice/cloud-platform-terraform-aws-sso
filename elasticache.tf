data "aws_iam_policy_document" "elasticache_for_github" {
  statement {
    sid    = "AllowElastiCacheListDescribe"
    effect = "Allow"
    actions = [
      "elasticache:Describe*",
      "elasticache:List*",
    ]
    resources = ["*"]
  }
}