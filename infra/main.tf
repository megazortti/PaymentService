module "hello_lambda" {
  source        = "./modules/lambda"
  function_name = "hello_lambda_minimal"
  source_path   = "./../lambda/hello_world"
  handler       = "index.handler"
  runtime       = "nodejs18.x"
}

module "hello_apigw" {
  source              = "./modules/api_gateway_http"
  name                = "hello_lambda_api"
  lambda_function_name = module.hello_lambda.function_name
  lambda_invoke_arn   = module.hello_lambda.invoke_arn
  route_key           = "GET /"
  domain_name         = var.payment_webhook_domain_name # ou null se quiser só teste direto
  certificate_arn     = aws_acm_certificate.cert.arn    # seu cert já criado no acm.tf
}
