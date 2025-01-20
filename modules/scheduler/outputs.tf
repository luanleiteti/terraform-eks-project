output "lambda_function_arn" {
  description = "ARN da função Lambda"
  value       = module.scheduler.lambda_function_arn
}

output "lambda_function_name" {
  description = "Nome da função Lambda"
  value       = module.scheduler.lambda_function_name
}

output "lambda_role_arn" {
  description = "ARN da role do Lambda"
  value       = module.scheduler.lambda_role_arn
}
