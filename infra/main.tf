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
  source_path     = "../lambda/payment_webhook"
}