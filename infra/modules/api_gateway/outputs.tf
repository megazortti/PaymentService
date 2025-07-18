output "invoke_url" {
  value = aws_apigatewayv2_api.api.api_endpoint
}

output "custom_domain_name" {
  value = aws_apigatewayv2_domain_name.custom_domain.domain_name
}

output "target_domain_name" {
  value = aws_apigatewayv2_domain_name.custom_domain.domain_name_configuration[0].target_domain_name
}
