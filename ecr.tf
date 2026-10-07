data "aws_iam_policy_document" "ecr_for_github" {
  statement {
    sid    = "AllowECRListDescribe"
    effect = "Allow"
    actions = [
      "ecr:DescribeRepositories"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowECRGetOwn"
    effect = "Allow"
    actions = [
      "ecr:Describe*",
      "ecr:Get*",
      "ecr:List*",
      "ecr:BatchGetImage"
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }

  # Account-level read actions that have no resource tags, so they can't use the tag condition
  statement {
    sid    = "AllowScanningRead"
    effect = "Allow"
    actions = [
      "ecr:GetRegistryScanningConfiguration"
    ]
    resources = ["*"]
  }
}