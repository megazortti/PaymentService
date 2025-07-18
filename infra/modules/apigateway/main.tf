terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }

  }
}

provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

resource "aws_acm_certificate" "cert" {
  provider          = aws.virginia
  domain_name       = var.custom_domain
  validation_method = "DNS"
}

resource "cloudflare_record" "cert_validation" {
  zone_id = var.cloudflare_zone_id

  name  = element(aws_acm_certificate.cert.domain_validation_options[*].resource_record_name, 0)
  type  = element(aws_acm_certificate.cert.domain_validation_options[*].resource_record_type, 0)
  value = element(aws_acm_certificate.cert.domain_validation_options[*].resource_record_value, 0)

  proxied = false
}

resource "aws_apigatewayv2_api" "api" {
  name          = "api-${var.custom_domain}"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id                 = aws_apigatewayv2_api.api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.lambda_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "default" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "ANY /"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_domain_name" "custom" {
  domain_name = var.custom_domain

  domain_name_configuration {
    certificate_arn = aws_acm_certificate.cert.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}
