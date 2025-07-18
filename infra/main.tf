module "simple_lambda" {
  source        = "./modules/lambda"
  function_name = "simple_lambda"
  source_path   = "../lambda/create_payment" # Pasta com seu código lambda zipado (index.js, etc)
  handler       = "index.handler"
  runtime       = "nodejs18.x"
}

module "simple_api_gateway" {
  source             = "./modules/api_gateway"
  name               = "simple_api"
  lambda_function_arn = module.simple_lambda.lambda_arn
  route_key          = "GET /"
  domain_name        = var.domain_name
  certificate_arn    = aws_acm_certificate_validation.cert_validation.certificate_arn
}

# Certificado ACM + DNS validation via Cloudflare
resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "cert_validation" {
  zone_id = var.cloudflare_zone_id
  name    = aws_acm_certificate.cert.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options[0].resource_record_type
  value   = aws_acm_certificate.cert.domain_validation_options[0].resource_record_value
  ttl     = 300
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [cloudflare_record.cert_validation.name]
}

resource "cloudflare_record" "api_cname" {
  zone_id = var.cloudflare_zone_id
  name    = var.domain_name
  type    = "CNAME"
  value   = module.simple_api_gateway.target_domain_name
  proxied = true
}
