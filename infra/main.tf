module "simple_lambda" {
  source        = "./modules/lambda"
  function_name = "simple_lambda"
  source_path   = "../lambda/create_payment" # Pasta com seu código lambda zipado (index.js, etc)
  handler       = "index.handler"
  runtime       = "nodejs18.x"
}

module "simple_api_gateway" {
  source             = "./modules/api_gateway"
  name               = "simple_api"
  lambda_function_arn = module.simple_lambda.lambda_arn
  route_key          = "GET /"
  domain_name        = var.domain_name
  certificate_arn    = aws_acm_certificate.cert.arn
}


resource "cloudflare_record" "api_cname" {
  zone_id = var.cloudflare_zone_id
  name    = var.domain_name
  type    = "CNAME"
  value   = module.simple_api_gateway.target_domain_name
  proxied = true
}
