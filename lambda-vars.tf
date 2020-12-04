variable "owner" {
  default = ""
}

variable "scope" {
  description = "Sub Project or Component"
  default = ""
}

variable "filename" {
  default = ""
}

variable "function_name" {
  default = ""
}

variable "function_description" {
  description = "Purpose of Lambda Function described."
  default = ""
}

variable "runtime" {
  description = "Valid Values: nodejs | nodejs4.3 | nodejs6.10 | nodejs8.10 | java8 | python2.7 | python3.6 | dotnetcore1.0 | dotnetcore2.0 | dotnetcore2.1 | nodejs4.3-edge | go1.x"
  default = "python3.8"
}

variable "timeout" {
  description = "Function timeout"
  default = 500
}

variable "memory_size" {
  description = "(Optional) Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128."
  default = 128
}

variable "dead_letter_config" {
  type = object({
    target_arn = string
  })
  default = null
}

variable "environment" {
  type = object({
    variables = map(string)
  })
  default = null
}

variable "tracing_config" {
  type = object({
    mode = string
  })
  default = null
}

variable "vpc_config" {
  type = object({
    security_group_ids = list(string)
    subnet_ids         = list(string)
  })
  default = null
}

variable "role_arn" {
  default = ""
}

variable "lambda_source_arn" {
  default = ""
}

variable "variables" {
  default = {}
}

variable "kms_key_arn" {
  description = "kms_key_arn"
  default = null
}