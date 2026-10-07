data "aws_iam_policy_document" "inspector_for_github" {
  # Account-level read actions that have no resource tags, so they can't use the tag condition
  statement {
    sid    = "AllowScanningFindings"
    effect = "Allow"
    actions = [
      "inspector2:ListCoverage",
      "inspector2:ListFindings"
    ]
    resources = ["*"]
  }
}