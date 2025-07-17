output "api_id" {
  value = aws_apigatewayv2_api.this.id
}

output "execution_arn" {
  value = aws_apigatewayv2_api.this.execution_arn
}

output "url" {
  value = "https://${var.domain_name != null ? var.domain_name : aws_apigatewayv2_api.this.api_endpoint}"
}
