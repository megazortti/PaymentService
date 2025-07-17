variable "name" {
  description = "Nome da API"
  type        = string
}

variable "lambda_function_name" {
  description = "Nome da função Lambda"
  type        = string
}

variable "lambda_invoke_arn" {
  description = "ARN de invocação da função Lambda"
  type        = string
}

variable "route_key" {
  description = "Chave da rota (ex: POST /webhook)"
  type        = string
}

variable "domain_name" {
  description = "Domínio customizado (opcional)"
  type        = string
  default     = null
}

variable "certificate_arn" {
  description = "ARN do certificado ACM (obrigatório se usar domínio)"
  type        = string
  default     = null
}
