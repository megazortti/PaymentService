resource "aws_ssm_parameter" "mercadopago_token" {
  name        = "/secrets/mercadopago/pix_token"
  type        = "SecureString"
  value       = var.mercadopago_token
  description = "Token de acesso do MercadoPago para pagamentos via Pix"
  overwrite   = true
}
