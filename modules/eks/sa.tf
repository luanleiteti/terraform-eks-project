resource "kubernetes_service_account" "app" {
  metadata {
    name      = var.service_account_name
    namespace = var.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.service_account.arn
    }
    labels = {
      "app.kubernetes.io/name" = var.service_account_name
    }
  }
}

resource "aws_iam_role" "service_account" {
  name = "${var.service_account_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity"
      Effect = "Allow"
      Principal = {
        Federated = aws_iam_openid_connect_provider.eks.arn
      }
      Condition = {
        StringEquals = {
          "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub" : "system:serviceaccount:${var.namespace}:${var.service_account_name}"
        }
      }
    }]
  })
}

# # DynamoDB Policy
# resource "aws_iam_role_policy" "dynamodb" {
#   name = "${var.service_account_name}-dynamodb-policy"
#   role = aws_iam_role.service_account.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "dynamodb:GetItem",
#           "dynamodb:PutItem",
#           "dynamodb:UpdateItem",
#           "dynamodb:DeleteItem",
#           "dynamodb:Query",
#           "dynamodb:Scan",
#           "dynamodb:BatchGetItem",
#           "dynamodb:BatchWriteItem"
#         ]
#         Resource = [
#           "arn:aws:dynamodb:${var.region}:${var.account_id}:table/${var.dynamodb_table_name}",
#           "arn:aws:dynamodb:${var.region}:${var.account_id}:table/${var.dynamodb_table_name}/*"
#         ]
#       }
#     ]
#   })
# }

# # RDS Policy
# resource "aws_iam_role_policy" "rds" {
#   name = "${var.service_account_name}-rds-policy"
#   role = aws_iam_role.service_account.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "rds-db:connect",
#           "rds:DescribeDBInstances",
#           "rds:ListTagsForResource"
#         ]
#         Resource = var.rds_instance_arn
#       }
#     ]
#   })
# }

# # S3 Policy
# resource "aws_iam_role_policy" "s3" {
#   name = "${var.service_account_name}-s3-policy"
#   role = aws_iam_role.service_account.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "s3:GetObject",
#           "s3:PutObject",
#           "s3:DeleteObject",
#           "s3:ListBucket"
#         ]
#         Resource = [
#           "arn:aws:s3:::${var.s3_bucket_name}",
#           "arn:aws:s3:::${var.s3_bucket_name}/*"
#         ]
#       }
#     ]
#   })
# }

# # SQS Policy
# resource "aws_iam_role_policy" "sqs" {
#   name = "${var.service_account_name}-sqs-policy"
#   role = aws_iam_role.service_account.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "sqs:SendMessage",
#           "sqs:ReceiveMessage",
#           "sqs:DeleteMessage",
#           "sqs:GetQueueAttributes"
#         ]
#         Resource = var.sqs_queue_arn
#       }
#     ]
#   })
# }

# # Secrets Manager Policy
# resource "aws_iam_role_policy" "secrets" {
#   name = "${var.service_account_name}-secrets-policy"
#   role = aws_iam_role.service_account.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "secretsmanager:GetSecretValue",
#           "secretsmanager:DescribeSecret"
#         ]
#         Resource = var.secrets_arn
#       }
#     ]
#   })
# }
