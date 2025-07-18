resource "cloudflare_record" "apigw_alias" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "CNAME"
  value   = var.target_domain
  proxied = true
}
