terraform {
  required_providers {
    auth0 = {
      source  = "auth0/auth0"
      version = "1.36.0"
    }
  }
}

//Auth0 Custom Database
resource "auth0_connection" "my_connection" {
  name     = "AWS-Cognito-Connection"
  strategy = "auth0"
  options {
    import_mode     = true
    password_policy = "good"
    password_history {
      enable = true
      size   = 3
    }
    enabled_database_customization = "true"
    custom_scripts = {
      //create          = templatefile("${path.module}/methods/create.js", { auth0_domain = "${var.auth0_domain}", awsAPIGatewayURL = "${var.awsAPIGatewayURL}" })
      //verify          = templatefile("${path.module}/methods/verify.js", { auth0_domain = "${var.auth0_domain}", awsAPIGatewayURL = "${var.awsAPIGatewayURL}" })
      get_user = templatefile("${path.module}/methods/getUser.js", {})
      login    = templatefile("${path.module}/methods/login.js", {})
      //delete          = templatefile("${path.module}/methods/delete.js", { auth0_domain = "${var.auth0_domain}", awsAPIGatewayURL = "${var.awsAPIGatewayURL}" })
      //change_password = templatefile("${path.module}/methods/changePassword.js", { auth0_domain = "${var.auth0_domain}", awsAPIGatewayURL = "${var.awsAPIGatewayURL}" })
    }
    configuration = {
      "region"          = var.aws_region
      "ClientId"        = var.aws_cognito_app_client_id
      "UserPoolId"      = var.aws_cognito_user_pool_id
      "accessKeyId"     = var.aws_access_key
      "secretAccessKey" = var.aws_secret_key
    }
  }
}