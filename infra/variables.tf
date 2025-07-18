variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID"
  type        = string
}

variable "domain_name" {
  description = "Domínio customizado para a API Gateway"
  type        = string
}

variable "lambda_source_path" {
  description = "Caminho da pasta com código da Lambda"
  type        = string
}
