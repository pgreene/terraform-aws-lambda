variable "aws_region" {
  description = "AWS region"
  default     = null
}

variable "env_name" {
  description = "Environment name"
  default     = null
}

variable "tags" {
  description = "(Optional) Map of tags to assign to the object. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  default = null
}

variable "filename" {
  description = "(Optional) Path to the function's deployment package within the local filesystem. Conflicts with image_uri, s3_bucket, s3_key, and s3_object_version."
  default = null
}

variable "s3_bucket" {
  description = "(Optional) S3 bucket name where the function's deployment package is stored."
  default = null
}

variable "s3_key" {
  description = "(Optional) S3 object key where the function's deployment package is stored."
  default = null
}

variable "s3_object_version" {
  description = "(Optional) S3 object version where the function's deployment package is stored."
  default = null
}

variable "function_name" {
  description = "(Required) Unique name for your Lambda Function."
  default = null
}

variable "handler" {
  description = "(Optional) Function entrypoint in your code."
  default = null
}

variable "source_code_hash" {
  description = "(Optional) Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key."
  default = null # example: base64sha256(filesha256(join("",[var.filename])))
}
variable "function_description" {
  description = "Purpose of Lambda Function described."
  default = null
}

variable "runtime" {
  description = "Valid Example Values: nodejs | nodejs4.3 | nodejs6.10 | nodejs8.10 | java8 | python2.7 | python3.6 | dotnetcore1.0 | dotnetcore2.0 | dotnetcore2.1 | nodejs4.3-edge | go1.x"
  default = "python3.13"
}

variable "timeout" {
  description = "(Optional) Amount of time your Lambda Function has to run in seconds. Defaults to 3. See Limits."
  default = 600
}

variable "layers" {
  description = "(Optional) List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function."
  default = null
}

variable "memory_size" {
  description = "(Optional) Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128 if not set."
  default = 128
}

variable "architectures" {
  description = "(Optional) List of processor architectures your Lambda Function can run on. Valid values are arm64 and x86_64."
  default = ["arm64"]
}

variable "dead_letter_config" {
  description = "(Optional) Dead letter queue configuration that specifies the queue or topic where Lambda sends asynchronous events when they fail processing."
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
  description = "For network connectivity to AWS resources in a VPC, specify a list of security groups and subnets in the VPC. When you connect a function to a VPC, it can only access resources and the internet through that VPC. See VPC Settings."
  type = object({
    security_group_ids = list(string)
    subnet_ids         = list(string)
  })
  default = null
}

variable "file_system_config" {
  description = "Connection settings for an EFS file system. Before creating or updating Lambda functions with file_system_config, EFS mount targets must be in available lifecycle state. Use depends_on to explicitly declare this dependency."
  default = null
}

variable "role_arn" {
  description = "(Required) Amazon Resource Name (ARN) of the function's execution role. The role provides the function's identity and access to AWS services and resources."
  default = null
}

variable "lambda_source_arn" {
  default = null
}

variable "variables" {
  default = null
}

variable "kms_key_arn" {
  description = "(Optional) Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key. If this configuration is provided when environment variables are not in use, the AWS Lambda API does not save this configuration and Terraform will show a perpetual difference of adding the key. To fix the perpetual difference, remove this configuration."
  default = null
}

variable "create_lambda_layer" {
  description = "Whether to create a Lambda layer."
  type        = bool
  default     = false
}

variable "lambda_layer_description" {
  description = "Description for the Lambda layer."
  default     = null
}

variable "lambda_layer_name" {
  description = "Name for the Lambda layer."
  default     = null
}

variable "lambda_layer_filename" {
  description = "The path to the zip file for the Lambda layer."
  default     = null
}

variable "lambda_layer_runtime" {
  description = "Runtime for the Lambda layer."
  default     = null
}

variable "lambda_layer_architecture" {
  description = "Architecture for the Lambda layer."
  default     = "arm64"
}

variable "lambda_layer_s3_bucket" {
  description = "S3 bucket for the Lambda layer."
  default     = null
}

variable "lambda_layer_s3_key" {
  description = "S3 key for the Lambda layer."
  default     = null
}

variable "lambda_layer_s3_object_version" {
  description = "S3 object version for the Lambda layer."
  default     = null
}

variable "lambda_layer_source_code_hash" {
  description = "Source code hash for the Lambda layer."
  default     = null
}

variable "lambda_layer_license_info" {
  description = "License info for the Lambda layer."
  default     = null
}

variable "lambda_layer_skip_destroy" {
  description = "Skip destroy for the Lambda layer."
  type        = bool
  default     = false
}

# function url variables

variable "create_lambda_function_url" {
  description = "Whether to create a Lambda function URL."
  type        = bool
  default     = false
}

variable "authorization_type" {
    description = "(Required) Type of authentication that the function URL uses. Valid values are AWS_IAM and NONE"
    type = string
    default = "NONE"
}

variable "invoke_mode" {
    description = "(Optional) How the Lambda function responds to an invocation. Valid values are BUFFERED (default) and RESPONSE_STREAM."
    type = string
    default = "BUFFERED"
}

variable "qualifier" {
    description = "(Optional) Alias name or $LATEST."
    type = string
    default = null
}

variable "cors" {
    description = "(Optional) Cross-origin resource sharing (CORS) settings for the function URL."
    default = null
}

# lambda permission variables
variable "create_lambda_permission" {
  description = "Whether to create a Lambda permission."
  type        = bool
  default     = false
}

variable "statement_id" {
  description = "(Required) A unique statement identifier."
  type        = string
  default     = null
}

variable "action" {
  description = "(Required) The AWS service or external entity that is calling the Lambda Function."
  type        = string
  default     = null
}

variable "principal" {
  description = "(Required) The principal that is associated with the permission. This is typically an AWS service or another account."
  type        = string
  default     = null
}

variable "source_arn" {
  description = "(Optional) The ARN of the resource that is invoking the Lambda Function."
  type        = string
  default     = null
}
