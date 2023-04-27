data "aws_iam_policy_document" "secretsmanager_for_github" {
  statement {
    sid    = "AllowSecretsManagerListDescribe"
    effect = "Allow"
    actions = [
      "secretsmanager:ListSecrets",
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowSecretsManagerGetPutValue"
    effect = "Allow"
    actions = [
      "secretsmanager:DescribeSecret",
      "secretmanager:ListSecretVersionIds",
      "secretsmanager:GetSecretValue",
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:PutSecretValue",
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }
}
