output "api_invoke_url" {
  value = module.api_gateway.invoke_url
}

output "custom_domain_name" {
  value = module.api_gateway.target_domain_name
}
