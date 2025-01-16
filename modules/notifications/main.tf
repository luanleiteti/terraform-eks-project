# Platform Application para Android (FCM/GCM)
resource "aws_sns_platform_application" "android" {
  name                = "${var.environment}-${var.application_name}-android"
  platform            = "FCM"
  platform_credential = var.fcm_server_key
}

# Tópico SNS para notificações
resource "aws_sns_topic" "notifications" {
  name = "${var.environment}-${var.application_name}-notifications"

  tags = var.tags
}