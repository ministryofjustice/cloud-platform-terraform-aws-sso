data "aws_iam_policy_document" "athena_for_github" {
  statement {
    sid    = "AllowAthenaList"
    effect = "Allow"
    actions = [
      "athena:ListWorkGroups",
      "athena:ListEngineVersions",
      "athena:ListDataCatalogs",
      "athena:ListDatabases",
      "athena:GetDatabase",
      "athena:ListTableMetadata",
      "athena:GetTableMetadata"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowAthenaViewOwn"
    effect = "Allow"
    actions = [
      "athena:GetWorkGroup",
      "athena:ListTagsForResource",
      "athena:GetQueryExecution",
      "athena:BatchGetQueryExecution",
      "athena:ListQueryExecutions",
      "athena:GetQueryResults",
      "athena:GetQueryResultsStream",
      "athena:GetNamedQuery",
      "athena:BatchGetNamedQuery",
      "athena:ListNamedQueries",
      "athena:GetPreparedStatement",
      "athena:ListPreparedStatements",
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }
}
