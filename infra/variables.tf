variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API Token"
}

variable "cloudflare_zone_id" {
  type        = string
  description = "Cloudflare Zone ID"
}

variable "domain_name" {
  type        = string
  description = "Custom domain name"
}
