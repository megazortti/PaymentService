resource "aws_ssm_parameter" "mercadopago_access_token" {
  name        = "/secrets/mercadopago/access_token"
  type        = "SecureString"
  value       = "CHANGE_HERE"
  description = "Token de acesso do MercadoPago para pagamentos"
}

resource "aws_ssm_parameter" "mercadopago_client_secret_token" {
  name        = "/secrets/mercadopago/client_secret"
  type        = "SecureString"
  value       = "CHANGE_HERE"
  description = "Token de acesso do MercadoPago secret"
}

resource "aws_ssm_parameter" "mercadopago_notification_token" {
  name        = "/secrets/mercadopago/notification_token"
  type        = "SecureString"
  value       = "CHANGE_HERE"
  description = "Token de acesso do MercadoPago para notificações"
}