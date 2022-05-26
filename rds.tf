data "aws_iam_policy_document" "rds_for_github" {

  statement {
    sid    = "AllowListDescribe"
    effect = "Allow"
    actions = [
      "rds:Describe*",
      "rds:ListTagsForResource",
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowGetOwn"
    effect = "Allow"
    actions = [
      "rds:CreateDBSnapshot",
      "rds:ModifyDBInstance",
      "rds:RebootDBInstance"
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }

}

resource "aws_iam_policy" "rds_for_github" {
  policy = data.aws_iam_policy_document.rds_for_github.json
  name   = "rds-for-github"
  tags = {
    GithubTeam = "webops"
  }
}

resource "aws_iam_role_policy_attachment" "rds_for_github" {
  role       = aws_iam_role.github_access.name
  policy_arn = aws_iam_policy.rds_for_github.arn
}
