data "aws_iam_policy_document" "opensearch_for_github" {

  statement {
    sid    = "AllowListDescribe"
    effect = "Allow"
    actions = [
      "es:DescribeDomain",
      "es:ListDomainNames",
      "es:ListTags"
    ]
    resources = ["*"]
  }

}

resource "aws_iam_policy" "opensearch_for_github" {
  policy = data.aws_iam_policy_document.opensearch_for_github.json
  name   = "opensearch-for-github"
  tags = {
    GithubTeam = "webops"
  }
}

resource "aws_iam_role_policy_attachment" "opensearch_for_github" {
  role       = aws_iam_role.github_access.name
  policy_arn = aws_iam_policy.opensearch_for_github.arn
}
