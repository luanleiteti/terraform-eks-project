variable "name_prefix" {
  description = "Prefix to be used for resource names"
  type        = string
  default     = "cluster-scheduler"
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "rds_cluster_name" {
  description = "Name of the RDS cluster"
  type        = string
}

variable "start_schedule" {
  description = "Cron expression for starting clusters"
  type        = string
  default     = "cron(0 7 ? * MON-FRI *)"
}

variable "stop_schedule" {
  description = "Cron expression for stopping clusters"
  type        = string
  default     = "cron(0 22 ? * MON-FRI *)"
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
}

variable "eks_nodegroup_name" {
  description = "Nome do node group do EKS"
  type        = string
}

variable "rds_instance_name" {
  description = "Nome da instância RDS"
  type        = string
}
