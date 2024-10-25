data "aws_iam_policy_document" "backups_for_github" {
  statement {
    sid    = "AllowCognitoList"
    effect = "Allow"
    actions = [
      "backup:ListBackupVaults",
      "backup:ListBackupPlans"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowCognitoGetOwn"
    effect = "Allow"
    actions = [
      "backup:Describe*",
      "backup:Get*",
      "backup:List*"
    ]
    resources = [
      "arn:aws:cognito-idp:*:${data.aws_caller_identity.current.account_id}:userpool/*",
      "arn:aws:wafv2:*:${data.aws_caller_identity.current.account_id}:*/webacl/*/*"
    ]

    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }
}
