variable "aws_region" {
  description = "Região AWS"
  default     = "us-east-1"
}

variable "cloudflare_api_token" {
  description = "API Token Cloudflare com permissão DNS"
  type        = string
  sensitive   = true
}

variable "domain_name" {
  description = "mazzotti.app"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "ID da zona DNS do domínio no Cloudflare"
  type        = string
}
