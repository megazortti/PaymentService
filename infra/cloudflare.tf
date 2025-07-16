data "cloudflare_zone" "main" {
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "apigw_alias" {
  zone_id = data.cloudflare_zone.main.id
  name    = var.domain_name
  type    = "CNAME"
  value   = aws_apigatewayv2_domain_name.custom_domain.domain_name_configuration[0].target_domain_name
  proxied = true
  depends_on = [
    aws_apigatewayv2_domain_name.custom_domain,
    aws_apigatewayv2_api_mapping.mapping
  ]
}

resource "cloudflare_record" "validation" {
  zone_id = data.cloudflare_zone.main.id
  name  = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_name
  type  = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_type
  value = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_value
  ttl     = 300
}
