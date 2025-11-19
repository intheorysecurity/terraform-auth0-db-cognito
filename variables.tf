//auth0 vars
variable "auth0_client_name" {
  description = "Client Name, used for labeling AWS Cognito DB"
  type        = string
  default     = "sampleClient"
}

variable "auth0_domain" {
  description = "Auth0 Domain"
  type        = string
  default     = "poc.us.auth0.com"
}

variable "auth0_clientID" {
  description = "Auth0 Application Client ID"
  type        = string
  default     = "clientID"
}

variable "auth0_client_secret" {
  description = "Auth0 Application Client Secret"
  type        = string
  default     = "clientSecret"
}

variable "auth0_debug" {
  type    = bool
  default = false
}

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

variable "aws_session_token" {
  description = "AWS Session Token"
  type        = string
  default     = ""
}

variable "aws_account_number" {
  description = "AWS Account Number"
  type        = string
  default     = "1234567890"
}