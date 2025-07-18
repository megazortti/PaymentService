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

module "cloudflare" {
  source        = "./modules/cloudflare"
  domain_name   = var.domain_name
  zone_id       = var.cloudflare_zone_id
  target_domain = module.apigw.api_gateway_domain
}
