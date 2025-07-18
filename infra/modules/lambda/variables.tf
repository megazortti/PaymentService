variable "function_name" { type = string }
variable "source_path"   { type = string }
variable "handler"       { type = string }
variable "runtime"       { type = string }
variable "memory_size"   { type = number, default = 128 }
variable "timeout"       { type = number, default = 3 }
