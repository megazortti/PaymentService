module "hello_lambda" {
  source        = "../modules/lambda"
  function_name = "hello_lambda_minimal"
  source_path   = "../../lambda_functions/hello"
  handler       = "index.handler"
  runtime       = "nodejs18.x"
}
