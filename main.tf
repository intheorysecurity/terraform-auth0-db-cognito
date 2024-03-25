module "cognito" {
  source      = "./modules/cognito"
  client_name = var.auth0_client_name
}

module "auth0connections" {
  source                    = "./modules/auth0connections"
  aws_region                = var.aws_region
  aws_access_key            = var.aws_access_key
  aws_secret_key            = var.aws_secret_key
  aws_cognito_app_client_id = module.cognito.cognito_client_id
  aws_cognito_user_pool_id  = module.cognito.cognito_user_pool_id
  depends_on = [
    module.cognito
  ]
}