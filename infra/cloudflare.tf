data "cloudflare_zone" "main" {
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "apigw_alias" {
  zone_id = var.cloudflare_zone_id
  name    = var.domain_name
  type    = "CNAME"
  value   = module.payment_webhook_apigw.target_domain_name   # Certifique que o módulo exporta isso em outputs.tf
  proxied = true
}


resource "cloudflare_record" "validation" {
  zone_id = data.cloudflare_zone.main.id
  name  = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_name
  type  = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_type
  value = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_value
  ttl     = 300
}

