output "function_name" {
    value = aws_lambda_function.general.function_name
    description = "Unique name for your Lambda Function."
}

output "arn" {
  value = aws_lambda_function.general.arn
  description = "Amazon Resource Name (ARN) identifying your Lambda Function."
}

output "invoke_arn" {
  value = aws_lambda_function.general.invoke_arn
  description = "ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration uri."
}

output "last_modified" {
  value = aws_lambda_function.general.last_modified
  description = "Date this resource was last modified."
}

output "qualified_arn" {
  value = aws_lambda_function.general.qualified_arn
  description = "ARN identifying your Lambda Function Version (if versioning is enabled via publish = true)."
}

output "signing_job_arn" {
  value = aws_lambda_function.general.signing_job_arn
  description = "ARN of the signing job."
}

output "signing_profile_version_arn" {
  value = aws_lambda_function.general.signing_profile_version_arn
  description = "ARN of the signing profile version."
}

output "source_code_size" {
  value = aws_lambda_function.general.source_code_size
  description = "Size in bytes of the function .zip file."
}

output "tags_all" {
  value = aws_lambda_function.general.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}

output "lambda_version" {
  value = aws_lambda_function.general.version
  description = "Latest published version of your Lambda Function."
}

# function url

output "function_arn" {
  value       = var.create_lambda_function_url && length(aws_lambda_function_url.general) > 0 ? aws_lambda_function_url.general[0].function_arn : null
  description = "Function URL ARN, if created"
}

output "function_url" {
  value       = var.create_lambda_function_url && length(aws_lambda_function_url.general) > 0 ? aws_lambda_function_url.general[0].function_url : null
  description = "Function URL, if created"
}

output "url_id" {
  value       = var.create_lambda_function_url && length(aws_lambda_function_url.general) > 0 ? aws_lambda_function_url.general[0].url_id : null
  description = "Function URL ID, if created"
}
