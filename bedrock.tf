data "aws_iam_policy_document" "bedrock_for_github" {
  statement {
    sid    = "AllowBedrockReadOnly"
    effect = "Allow"
    actions = [
      "bedrock:GetFoundationModel",
      "bedrock:ListFoundationModels",
      "bedrock:ListTagsForResource",
      "bedrock:GetFoundationModelAvailability",
      "bedrock:GetModelInvocationLoggingConfiguration",
      "bedrock:GetProvisionedModelThroughput",
      "bedrock:ListProvisionedModelThroughputs",
      "bedrock:GetModelInvocationJob",
      "bedrock:ListModelInvocationJobs",
      "bedrock:GetGuardrail",
      "bedrock:ListGuardrails",
      "bedrock:GetEvaluationJob",
      "bedrock:ListEvaluationJobs",
      "bedrock:GetInferenceProfile",
      "bedrock:ListInferenceProfiles"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowBedrockCustomModel"
    effect = "Allow"
    actions = [
      "bedrock:GetModelCustomizationJob",
      "bedrock:ListModelCustomizationJobs",
      "bedrock:ListCustomModels",
      "bedrock:GetCustomModel"
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/GithubTeam"
      values   = ["*:$${aws:ResourceTag/GithubTeam}:*"]
    }
  }
}
