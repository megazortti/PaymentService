output "invoke_url" {
  value = aws_apigatewayv2_api.api.api_endpoint
}

output "custom_domain_name" {
  value = aws_apigatewayv2_domain_name.custom_domain.domain_name
}

output "custom_domain_url" {
  value = "https://${var.domain_name}/"
}
