resource "aws_lambda_function" "general" {
  filename = var.filename
  function_name = var.function_name
  description = var.function_description
  role = var.role_arn
  handler = var.handler
  source_code_hash = var.source_code_hash # base64sha256(filesha256(join("",[var.filename])))
  runtime = var.runtime
  timeout = var.timeout
  memory_size = var.memory_size
  kms_key_arn = var.kms_key_arn
  layers = var.layers

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
      # EFS file system access point ARN
      #arn = aws_efs_access_point.access_point_for_lambda.arn
      arn = file_system_config.value.arn
      # Local mount path inside the lambda function. Must start with '/mnt/'.
      #local_mount_path = "/mnt/efs"
      local_mount_path = file_system_config.value.local_mount_path
    }
  }

  tags = var.tags
}

#resource "aws_lambda_permission" "allow_cloudwatch" {
#  statement_id = "AllowExecutionFromCloudWatch"
#  action = "lambda:InvokeFunction"
#  function_name = aws_lambda_function.general.function_name
#  principal = "events.amazonaws.com"
#  source_arn = var.lambda_source_arn
#}
