data "aws_iam_policy_document" "api_gateway_for_github" {
  statement {
    sid       = "AllowAPIGatewayGetOwn"
    effect    = "Allow"
    actions   = ["apigateway:GET"]
    resources = [
				"arn:aws:apigateway:eu-west-2::/account",
				"arn:aws:apigateway:eu-west-2::/restapis",
				"arn:aws:apigateway:eu-west-2::/apis/*",
				"arn:aws:apigateway:eu-west-2::/domainnames",
				"arn:aws:apigateway:eu-west-2::/vpclinks",
				"arn:aws:apigateway:eu-west-2::/apis"
			]
  }
}
