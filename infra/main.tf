module "lambda" {
  source        = "./modules/lambda"
  function_name = "simple_lambda"
  source_path   = var.lambda_source_path
  handler       = "index.handler"
  runtime       = "nodejs18.x"
}

module "acm" {
  source             = "./modules/acm"
  domain_name        = var.domain_name
  cloudflare_zone_id = var.cloudflare_zone_id
}

module "api_gateway" {
  source              = "./modules/api_gateway"
  name                = "simple_api"
  lambda_function_arn = module.lambda.lambda_arn
  route_key           = "GET /"
  domain_name         = var.domain_name
  certificate_arn     = module.acm.certificate_arn
}

resource "cloudflare_record" "api_cname" {
  zone_id = var.cloudflare_zone_id
  name    = var.domain_name
  type    = "CNAME"
  value   = module.api_gateway.target_domain_name
  proxied = true
}
