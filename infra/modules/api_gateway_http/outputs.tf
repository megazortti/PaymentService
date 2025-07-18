output "api_id" {
  value = aws_apigatewayv2_api.this.id
}

output "url" {
  value = aws_apigatewayv2_api.this.api_endpoint
}

output "custom_domain_name" {
  value = var.domain_name != null ? aws_apigatewayv2_domain_name.custom_domain[0].domain_name : null
}

output "custom_domain_target" {
  value = var.domain_name != null ? aws_apigatewayv2_domain_name.custom_domain[0].domain_name_configuration[0].target_domain_name : null
}
