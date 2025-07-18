data "cloudflare_zone" "main" {
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "apigw_alias" {
  zone_id = var.cloudflare_zone_id
  name    = var.domain_name
  type    = "CNAME"
  value   = module.apigw.api_gateway_domain  # Use o nome correto do seu módulo de API Gateway
  proxied = false
  lifecycle {
    prevent_destroy = true   # evita apagar sem querer
    ignore_changes  = [name, value]  # ignora mudanças nesses campos para não recriar
  }
  allow_overwrite = true
}

resource "aws_ses_domain_identity_verification" "mazzotti_verification" {
  domain = aws_ses_domain_identity.mazzotti.domain
}

resource "cloudflare_record" "ses_verification" {
  zone_id = var.cloudflare_zone_id
  name    = "_amazonses.${aws_ses_domain_identity.mazzotti.domain}"
  type    = "TXT"
  value   = aws_ses_domain_identity_verification.mazzotti_verification.verification_token
  ttl     = 3600
  proxied = false
}
