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
        "ecr:List*"
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }
}