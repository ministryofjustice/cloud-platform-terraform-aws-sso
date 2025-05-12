# read only dynamo db table based on team tag

data "aws_iam_policy_document" "dynamo_db_for_github" {
  statement {
    sid    = "AllowDynamoDBList"
    effect = "Allow"
    actions = [
      "dynamodb:ListTables",
      "dynamodb:DescribeTable",
      "dynamodb:ListTagsOfResource",
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowDynamoDBViewOwn"
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:DescribeTable",
      "dynamodb:ListTagsOfResource",
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }
}