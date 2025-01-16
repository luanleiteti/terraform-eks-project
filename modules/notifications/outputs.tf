output "sns_topic_arn" {
  description = "ARN do tópico SNS"
  value       = aws_sns_topic.notifications.arn
}

output "platform_application_arn" {
  description = "ARN da aplicação de plataforma Android"
  value       = aws_sns_platform_application.android.arn
}