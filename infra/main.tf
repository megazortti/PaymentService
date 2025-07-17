module "payment_webhook_lambda" {
  source        = "./modules/lambda"
  function_name = "payment_webhook_lambda"
  source_path   = "./../lambda/payment_webhook"
  handler       = "index.handler"
  runtime       = "nodejs18.x"
}

module "payment_webhook_apigw" {
  source              = "./modules/api_gateway_http"
  name                = "payment_webhook_api"
  lambda_function_name = module.payment_webhook_lambda.function_name
  lambda_invoke_arn    = module.payment_webhook_lambda.invoke_arn
  route_key           = "POST /webhook"
  domain_name         = var.payment_webhook_domain_name
  certificate_arn     = aws_acm_certificate.payment_webhook_cert.arn
}
