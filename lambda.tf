resource "aws_lambda_function" "lambda" {
  filename = var.filename
  function_name = var.function_name
  description = var.function_description
  role = var.role_arn
  handler = join("",[var.function_name,".lambda_handler"])
  source_code_hash = base64sha256(filesha256(join("",[var.filename])))
  
  runtime = var.runtime
  timeout = var.timeout
  memory_size = var.memory_size

  kms_key_arn = var.kms_key_arn

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

  tags = {
    Name = var.function_name
    Scope = var.scope
    Environment = terraform.workspace
    Owner = var.owner
    CreatedBy = "Terraform"
  }
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal = "events.amazonaws.com"
  source_arn = var.lambda_source_arn
}
