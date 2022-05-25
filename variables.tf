variable "aws_account_id" {
  description = "The AWS Account numeric ID"
  type        = string
}

variable "aws_callback_url" {
  description = "AWS SSO callback URL"
  type        = string
  default     = "https://signin.aws.amazon.com/saml"
}
