variable "domain_name" {
  description = "O domínio custom para a API"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Zone ID do Cloudflare para o domínio"
  type        = string
}

variable "cloudflare_api_token" {
  description = "Token API Cloudflare com permissões DNS"
  type        = string
  sensitive   = true
}
