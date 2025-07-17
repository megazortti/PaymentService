resource "aws_apigatewayv2_api" "payment_webhook_api" {
  name          = "payment_webhook_api"
  protocol_type = "HTTP"
}

resource "aws_lambda_permission" "payment_webhook_apigw" {
  statement_id  = "AllowAPIGatewayInvokePaymentWebhook"
  action        = "lambda:InvokeFunction"
  function_name = module.payment_webhook_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.payment_webhook_api.execution_arn}/*/*"
}

resource "aws_apigatewayv2_integration" "payment_webhook_lambda_integration" {
  api_id                 = aws_apigatewayv2_api.payment_webhook_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = module.payment_webhook_lambda.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "payment_webhook_route" {
  api_id    = aws_apigatewayv2_api.payment_webhook_api.id
  route_key = "POST /webhook"
  target    = "integrations/${aws_apigatewayv2_integration.payment_webhook_lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "payment_webhook_stage" {
  api_id      = aws_apigatewayv2_api.payment_webhook_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_domain_name" "payment_webhook_domain" {
  domain_name = var.payment_webhook_domain_name

  domain_name_configuration {
    certificate_arn = aws_acm_certificate.payment_webhook_cert.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_apigatewayv2_api_mapping" "payment_webhook_mapping" {
  api_id      = aws_apigatewayv2_api.payment_webhook_api.id
  domain_name = aws_apigatewayv2_domain_name.payment_webhook_domain.domain_name
  stage       = aws_apigatewayv2_stage.payment_webhook_stage.name
}