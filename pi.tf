data "aws_iam_policy_document" "pi_for_github" {

  statement {
    sid    = "AllowPerformanceInsights"
    effect = "Allow"
    actions = [
      "pi:*",
    ]
    resources = ["*"]
  }

}

resource "aws_iam_policy" "pi_for_github" {
  policy = data.aws_iam_policy_document.pi_for_github.json
  name   = "pi-for-github"
  tags = {
    GithubTeam = "webops"
  }
}

resource "aws_iam_role_policy_attachment" "pi_for_github" {
  role       = aws_iam_role.github_access.name
  policy_arn = aws_iam_policy.pi_for_github.arn
}
