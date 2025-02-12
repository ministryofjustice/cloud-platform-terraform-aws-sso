data "aws_iam_policy_document" "backups_for_github" {
  statement {
    sid    = "AllowBackupsList"
    effect = "Allow"
    actions = [
      "backup:ListBackupVaults",
      "backup:ListBackupPlans",
      "backup:ListBackupJobs",
      "backup:ListRestoreJobs",
      "backup:ListProtectedResources"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowBackupsGetOwn"
    effect = "Allow"
    actions = [
      "backup:Describe*",
      "backup:Get*",
      "backup:List*"
    ]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }
}
