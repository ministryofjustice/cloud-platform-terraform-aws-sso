data "aws_iam_policy_document" "kms_for_github" {

  statement {
    sid    = "AllowRead"
    effect = "Allow"
    actions = [
      "kms:DescribeKey",
      "kms:GetKeyPolicy",
      "kms:GetKeyRotationStatus",
      "kms:GetParametersForImport",
      "kms:GetPublicKey",
      "kms:ListAliases",
      "kms:ListGrants",
      "kms:ListKeyPolicies",
      "kms:ListKeys",
      "kms:ListResourceTags",
      "kms:ListRetirableGrants",
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowEncryptDecryptOwn"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey",
      "kms:GenerateDataKeyPair",
      "kms:GenerateDataKeyPairWithoutPlaintext",
      "kms:GenerateDataKeyWithoutPlaintext",
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }

}

resource "aws_iam_policy" "kms_for_github" {
  policy = data.aws_iam_policy_document.kms_for_github.json
  name   = "kms-for-github"
  tags = {
    GithubTeam = "webops"
  }
}

resource "aws_iam_role_policy_attachment" "kms_for_github" {
  role       = aws_iam_role.github_access.name
  policy_arn = aws_iam_policy.kms_for_github.arn
}
