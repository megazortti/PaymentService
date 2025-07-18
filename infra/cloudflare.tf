data "cloudflare_zone" "main" {
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "apigw_alias" {
  zone_id = var.cloudflare_zone_id
  name    = var.domain_name
  type    = "CNAME"
  value   = module.apigw.api_gateway_domain  # Use o nome correto do seu módulo de API Gateway
  proxied = true
  lifecycle {
    prevent_destroy = true   # evita apagar sem querer
    ignore_changes  = [name, value]  # ignora mudanças nesses campos para não recriar
  }
  allow_overwrite = true
}
