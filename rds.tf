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
      "rds:DownloadCompleteDBLogFile",
      "rds:DownloadDBLogFilePortion",
      "rds:ModifyDBInstance",
      "rds:RebootDBInstance",
      "rds:StartDBInstance"
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }
}
