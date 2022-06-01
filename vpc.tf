data "aws_iam_policy_document" "vpc_for_github" {

  statement {
    sid    = "AllowListDescribe"
    effect = "Allow"
    actions = [
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeAddresses",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNatGateways",
      "ec2:DescribeNetworkAcls",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeRouteTables",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSecurityGroupRules",
      "ec2:DescribeSubnets",
      "ec2:DescribeTags",
      "ec2:DescribeTransitGateways",
      "ec2:DescribeTransitGatewayVpcAttachments",
      "ec2:DescribeTransitGatewayRouteTables",
      "ec2:DescribeVpcPeeringConnections",
      "ec2:DescribeVpcAttribute",
      "ec2:DescribeVpcs"
    ]
    resources = ["*"]
  }

}

resource "aws_iam_policy" "vpc_for_github" {
  policy = data.aws_iam_policy_document.vpc_for_github.json
  name   = "vpc-for-github"
  tags = {
    GithubTeam = "webops"
  }
}

resource "aws_iam_role_policy_attachment" "vpc_for_github" {
  role       = aws_iam_role.github_access.name
  policy_arn = aws_iam_policy.vpc_for_github.arn
}
