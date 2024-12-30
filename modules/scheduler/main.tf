resource "aws_lambda_function" "cluster_scheduler" {
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  function_name    = "${var.name_prefix}-cluster-scheduler"
  role            = aws_iam_role.lambda_role.arn
  handler         = "cluster_scheduler.lambda_handler"
  runtime         = "python3.9"

  environment {
    variables = {
      EKS_CLUSTER_NAME   = var.eks_cluster_name
      RDS_CLUSTER_NAME   = var.rds_cluster_name
      EKS_NODEGROUP_NAME = var.eks_nodegroup_name
    }
  }

  timeout = 300

  tags = var.tags
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/files/cluster_scheduler.py"
  output_path = "${path.module}/.terraform/cluster_scheduler.zip"
}

# EventBridge Rules
resource "aws_cloudwatch_event_rule" "start_clusters" {
  name                = "${var.name_prefix}-start-clusters"
  description         = "Start EKS and RDS clusters"
  schedule_expression = var.start_schedule
  tags               = var.tags
}

resource "aws_cloudwatch_event_rule" "stop_clusters" {
  name                = "${var.name_prefix}-stop-clusters"
  description         = "Stop EKS and RDS clusters"
  schedule_expression = var.stop_schedule
  tags               = var.tags
}

resource "aws_cloudwatch_event_target" "start_clusters" {
  rule      = aws_cloudwatch_event_rule.start_clusters.name
  target_id = "StartClusters"
  arn       = aws_lambda_function.cluster_scheduler.arn

  input = jsonencode({
    action = "start"
  })
}

resource "aws_cloudwatch_event_target" "stop_clusters" {
  rule      = aws_cloudwatch_event_rule.stop_clusters.name
  target_id = "StopClusters"
  arn       = aws_lambda_function.cluster_scheduler.arn

  input = jsonencode({
    action = "stop"
  })
}

resource "aws_lambda_permission" "allow_eventbridge_start" {
  statement_id  = "AllowEventBridgeStart"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cluster_scheduler.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.start_clusters.arn
}

resource "aws_lambda_permission" "allow_eventbridge_stop" {
  statement_id  = "AllowEventBridgeStop"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cluster_scheduler.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.stop_clusters.arn
}
