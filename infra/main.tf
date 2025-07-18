module "lambda_hello" {
  source      = "./modules/lambda"
  lambda_name = "hello-world"
  handler     = "index.handler"
  runtime     = "nodejs18.x"
  source_path = "${path.module}/../lambda/create_payment"
}

module "apigw" {
  source           = "./modules/apigateway"
  lambda_arn       = module.lambda_hello.lambda_arn
  custom_domain    = var.domain_name
  cloudflare_zone_id = var.cloudflare_zone_id
}

module "payment_webhook" {
  source      = "./modules/lambda"
  lambda_name = "payment-webhook"
  handler     = "index.handler"
  runtime     = "nodejs18.x"
  source_path = "${path.module}/../lambda/payment_webhook"
}

module "apigw_payment_webhook" {
  source           = "./modules/apigateway"
  lambda_arn       = module.payment_webhook.lambda_arn
  custom_domain    = "pay.mazzotti.app"
  cloudflare_zone_id = var.cloudflare_zone_id
}

module "cloudflare" {
  source        = "./modules/cloudflare"
  domain_name   = var.domain_name
  zone_id       = var.cloudflare_zone_id
  target_domain = module.apigw.api_gateway_domain
}

module "cloudflare_payment_webhook" {
  source        = "./modules/cloudflare"
  domain_name   = "pay.mazzotti.app"
  zone_id       = var.cloudflare_zone_id
  target_domain = module.apigw_payment_webhook.api_gateway_domain
}
