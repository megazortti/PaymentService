output "api_gateway_domain" {
  value = aws_apigatewayv2_domain_name.custom.domain_name_configuration[0].target_domain_name
}
