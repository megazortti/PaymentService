output "invoke_url" {
  value = module.payment_webhook_apigw.api_endpoint
}

output "custom_domain_name" {
  value = module.payment_webhook_apigw.custom_domain_name
}

output "custom_domain_url" {
  value = "https://${var.domain_name}/"
}

