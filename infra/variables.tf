variable "domain_name" {
  description = "O domínio custom para a API"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
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
