resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Certificado SSL para ${var.domain_name}"
  }
}

resource "cloudflare_record" "cert_validation" {
  zone_id = var.cloudflare_zone_id
  name  = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_name
  type  = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_type
  value = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_value
  ttl   = 300
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [cloudflare_record.cert_validation.name]
}
