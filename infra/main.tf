module "simple_lambda" {
  source        = "./modules/lambda"
  function_name = "simple_lambda"
  source_path   = "../lambda/create_payment" # Pasta com seu código lambda zipado (index.js, etc)
  handler       = "index.handler"
  runtime       = "nodejs18.x"
}

module "payment_webhook_apigw" {
  source              = "./modules/api_gateway"
  name                = "payment_webhook_api"
  lambda_function_arn = module.payment_webhook_lambda.lambda_arn
  route_key           = "POST /webhook"
  domain_name         = var.payment_webhook_domain_name
  certificate_arn     = module.acm.certificate_arn  # exemplo se você modularizou o ACM
}



resource "cloudflare_record" "api_cname" {
  zone_id = var.cloudflare_zone_id
  name    = var.domain_name
  type    = "CNAME"
  value   = module.simple_api_gateway.target_domain_name
  proxied = true
}
