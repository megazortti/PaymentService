resource "aws_ssm_parameter" "mercadopago_token" {
  name        = "/secrets/mercadopago/pix_token"
  type        = "SecureString"
  value       = "CHANGE_HERE"
  description = "Token de acesso do MercadoPago para pagamentos via Pix"
}
