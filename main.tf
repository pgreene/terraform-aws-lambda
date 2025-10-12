resource "aws_lambda_function" "general" {
  filename = var.filename
  source_code_hash = var.source_code_hash # base64sha256(filesha256(join("",[var.filename])))
  s3_bucket = var.s3_bucket
  s3_key = var.s3_key
  s3_object_version = var.s3_object_version
  function_name = var.function_name
  description = var.function_description
  role = var.role_arn
  handler = var.handler
  runtime = var.runtime
  timeout = var.timeout
  memory_size = var.memory_size
  kms_key_arn = var.kms_key_arn
  layers = var.create_lambda_layer ? [aws_lambda_layer_version.optional_layer[0].arn] : []

  dynamic "dead_letter_config" {
    for_each = var.dead_letter_config == null ? [] : [var.dead_letter_config]
    content {
      target_arn = dead_letter_config.value.target_arn
    }
  }

  dynamic "environment" {
    for_each = var.environment == null ? [] : [var.environment]
    content {
      variables = environment.value.variables
    }
  }

  dynamic "tracing_config" {
    for_each = var.tracing_config == null ? [] : [var.tracing_config]
    content {
      mode = tracing_config.value.mode
    }
  }

  dynamic "vpc_config" {
    for_each = var.vpc_config == null ? [] : [var.vpc_config]
    content {
      security_group_ids = vpc_config.value.security_group_ids
      subnet_ids = vpc_config.value.subnet_ids
    }
  }

  dynamic "file_system_config" {
    for_each = var.file_system_config == null ? [] : [var.file_system_config]
    content {
      arn = file_system_config.value.arn
      local_mount_path = file_system_config.value.local_mount_path
    }
  }

  tags = var.tags
}

resource "aws_lambda_layer_version" "optional_layer" {
  count = var.create_lambda_layer ? 1 : 0
  
  description = var.lambda_layer_description
  filename         = var.lambda_layer_filename
  layer_name       = var.lambda_layer_name
  compatible_runtimes = [var.lambda_layer_runtime]
  compatible_architectures = [var.lambda_layer_architecture]
  license_info = var.lambda_layer_license_info
  s3_bucket = var.lambda_layer_s3_bucket
  s3_key = var.lambda_layer_s3_key
  s3_object_version = var.lambda_layer_s3_object_version
  source_code_hash = var.lambda_layer_source_code_hash
  skip_destroy = var.lambda_layer_skip_destroy
}

resource "aws_lambda_function_url" "general" {
  count = var.create_lambda_function_url ? 1 : 0

  function_name      = var.function_name
  authorization_type = var.authorization_type
  invoke_mode = var.invoke_mode
  qualifier = var.qualifier

  dynamic "cors" {
    for_each = var.cors == null ? [] : [var.cors]
    content {
      allow_credentials = cors.value.allow_credentials
      allow_headers     = cors.value.allow_headers
      allow_methods     = cors.value.allow_methods
      allow_origins     = cors.value.allow_origins
      expose_headers    = cors.value.expose_headers
      max_age           = cors.value.max_age
    }
  }
}

resource "aws_lambda_permission" "general" {
  count = var.create_lambda_permission ? 1 : 0
  statement_id = var.statement_id
  action = var.action
  function_name = var.function_name
  principal = var.principal
  source_arn = var.source_arn
  qualifier = var.qualifier
}

