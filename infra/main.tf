module "hello_lambda" {
  source        = "./modules/lambda"  # Subindo dois níveis
  function_name = "hello_lambda_minimal"
  source_path   = "./../lambda/create_payment"  # Caminho absoluto ou relativo corrigido
  handler       = "index.handler"
  runtime       = "nodejs18.x"
}

module "payment_webhook_lambda" {
  source          = "./modules/lambda"
  function_name   = "payment_webhook_lambda"
  handler         = "handler.webhook"
  runtime         = "nodejs18.x"
  environment     = {
    MERCADOPAGO_API_KEY = var.mercadopago_api_key
  }
  source_path     = "../lambdas/payment_webhook"
}