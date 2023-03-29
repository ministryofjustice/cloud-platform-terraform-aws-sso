data "aws_iam_policy_document" "iam_for_github" {
  statement {
    sid    = "AllowIAMListDescribe"
    effect = "Allow"
    actions = [
      "iam:ListRoles",
      "iam:ListPolicies",
      "kms:List*",
      "kms:Describe*"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowIAMGetOwn"
    effect = "Allow"
    actions = [
      "iam:Get*",
      "iam:List*",
      "kms:Get*"
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }
}
