variable "function_name" {}
variable "source_path" {}
variable "handler" {}
variable "runtime" {
  default = "nodejs18.x"
}
variable "memory_size" {
  default = 128
}
variable "timeout" {
  default = 3
}
