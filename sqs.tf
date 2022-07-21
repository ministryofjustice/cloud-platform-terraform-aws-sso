data "aws_iam_policy_document" "sqs_for_github" {

  statement {
    sid    = "AllowListDescribe"
    effect = "Allow"
    actions = [
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "ListDeadLetterSourceQueues,
      "sqs:ListQueues",
      "ListQueueTags"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowSendRecvOwn"
    effect = "Allow"
    actions = [
      "sqs:ReceiveMessage",
      "sqs:SendMessage"
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }

}

resource "aws_iam_policy" "sqs_for_github" {
  policy = data.aws_iam_policy_document.sqs_for_github.json
  name   = "sqs-for-github"
  tags = {
    GithubTeam = "webops"
  }
}

resource "aws_iam_role_policy_attachment" "sqs_for_github" {
  role       = aws_iam_role.github_access.name
  policy_arn = aws_iam_policy.sqs_for_github.arn
}
