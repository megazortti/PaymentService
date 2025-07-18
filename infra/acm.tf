resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "cert_validation" {
  zone_id = var.cloudflare_zone_id

  name  = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_name
  type  = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_type
  value = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_value
  lifecycle {
    prevent_destroy = true   # evita apagar sem querer
    ignore_changes  = [name, value]  # ignora mudanças nesses campos para não recriar
  }
  ttl = 300
  proxied = false
  allow_overwrite = true
}

resource "aws_ses_domain_identity" "mazzotti" {
  domain = "mazzotti.app"
}

resource "aws_ses_domain_dkim" "mazzotti_dkim" {
  domain = aws_ses_domain_identity.mazzotti.domain
}


resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [cloudflare_record.cert_validation.name]
}
