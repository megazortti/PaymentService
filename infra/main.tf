module "hello_lambda" {
  source        = "./modules/lambda"  # Subindo dois níveis
  function_name = "hello_lambda_minimal"
  source_path   = "./../lambda/create_payment"  # Caminho absoluto ou relativo corrigido
  handler       = "index.handler"
  runtime       = "nodejs18.x"
}