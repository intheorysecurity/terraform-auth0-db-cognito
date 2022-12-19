//aws vars
variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "aws_access_key" {
  description = "AWS Account Access Key"
  type        = string
  default     = "my-access-key"
}

variable "aws_secret_key" {
  description = "AWS Account Secret Key"
  type        = string
  default     = "my-secret-key"
}

variable "aws_cognito_app_client_id" {
  description = "AWS Cognito Client ID"
  type        = string
  default     = "ABC123"
}

variable "aws_cognito_user_pool_id" {
  description = "AWS Cognito User Pool ID"
  type        = string
  default     = "ABC123"
}
