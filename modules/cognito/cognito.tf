locals {
  users = [
    { id = 1, givenName = "Amy", familyName = "Lee", email = "amy.lee@example.com" },
    { id = 2, givenName = "Jesse", familyName = "Soto", email = "jesse.soto@example.com" },
    { id = 3, givenName = "Bertha", familyName = "Jones", email = "bertha.jones@example.com" },
    { id = 4, givenName = "Kylie", familyName = "Lee", email = "kylie.lee@example.com" },
  ]
}
resource "aws_cognito_user_pool" "auth0_user_demo_pool" {
  name = "${var.client_name}_auth0_user_demo_pool"

  schema {
    name                     = "terraform"
    attribute_data_type      = "Boolean"
    mutable                  = false
    required                 = false
    developer_only_attribute = false
  }

  schema {
    name                     = "foo"
    attribute_data_type      = "String"
    mutable                  = false
    required                 = false
    developer_only_attribute = false
    string_attribute_constraints {}
  }
}

resource "aws_cognito_user_pool_client" "client" {
  name = "auth0_client"

  user_pool_id = aws_cognito_user_pool.auth0_user_demo_pool.id

  generate_secret     = false
  explicit_auth_flows = ["ALLOW_ADMIN_USER_PASSWORD_AUTH", "ALLOW_CUSTOM_AUTH", "ALLOW_USER_SRP_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
}

resource "aws_cognito_user" "example" {
  for_each = {
    for index, user in local.users : user.id => user
  }
  user_pool_id = aws_cognito_user_pool.auth0_user_demo_pool.id
  username     = each.value.email
  password     = "Auth0R0cks!"

  attributes = {
    terraform      = true
    foo            = "bar"
    email          = each.value.email
    email_verified = true
    given_name     = each.value.givenName
    family_name    = each.value.familyName
  }
}

output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.auth0_user_demo_pool.id
}

output "cognito_client_id" {
  value = aws_cognito_user_pool_client.client.id
}