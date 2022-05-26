data "aws_iam_policy_document" "s3_for_github" {

  statement {
    sid    = "AllowListDescribe"
    effect = "Allow"
    actions = [
      "s3:GetBucketAcl",
      "s3:GetBucketLocation",
      "s3:ListAllMyBuckets",
      "s3:ListBucket",
      "s3:ListBucketVersions"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowGetOwn"
    effect = "Allow"
    actions = [
      "s3:ListBucket*",
      "s3:GetObject*"
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${s3:ExistingObjectTag/GithubTeam}:*"]
    }
  }

}

resource "aws_iam_policy" "s3_for_github" {
  policy = data.aws_iam_policy_document.s3_for_github.json
  name   = "s3-for-github"
  tags = {
    GithubTeam = "webops"
  }
}

resource "aws_iam_role_policy_attachment" "s3_for_github" {
  role       = aws_iam_role.github_access.name
  policy_arn = aws_iam_policy.s3_for_github.arn
}
