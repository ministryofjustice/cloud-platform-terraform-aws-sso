data "aws_iam_policy_document" "cognito_idp_for_github" {
  statement {
    sid    = "AllowCognitoList"
    effect = "Allow"
    actions = [
      "cognito-idp:ListUserPools",
      "cognito-idp:DescribeUserPoolDomain"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowCognitoGetOwn"
    effect = "Allow"
    actions = [
      "cognito-idp:List*",
      "cognito-idp:Describe*",
      "cognito-idp:Get*",
      "wafv2:GetWebACLForResource",
      "SNS:GetSMSSandboxAccountStatus"
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
