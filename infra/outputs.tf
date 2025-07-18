output "api_invoke_url" {
  value = module.simple_api_gateway.invoke_url
}

output "custom_domain" {
  value = var.domain_name
}
