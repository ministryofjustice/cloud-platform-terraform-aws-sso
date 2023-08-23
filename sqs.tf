data "aws_iam_policy_document" "sqs_for_github" {
  statement {
    sid    = "AllowSQSListDescribe"
    effect = "Allow"
    actions = [
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ListDeadLetterSourceQueues",
      "sqs:ListQueues",
      "sqs:ListQueueTags"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowSQSSendRecvOwn"
    effect = "Allow"
    actions = [
      "sqs:CancelMessageMoveTask",
      "sqs:ChangeMessageVisibility",
      "sqs:DeleteMessage",
      "sqs:ListMessageMoveTasks",
      "sqs:ReceiveMessage",
      "sqs:SendMessage",
      "sqs:StartMessageMoveTask",
      "sqs:PurgeQueue"
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }
}
