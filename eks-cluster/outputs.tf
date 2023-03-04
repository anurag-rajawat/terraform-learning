output "cluster_name" {
  value       = aws_eks_cluster.cluster.name
  description = "Name of EKS cluster"
}

output "cluster_arn" {
  value       = aws_eks_cluster.cluster.arn
  description = "The ARN of EKS cluster"
}


output "cluster_endpoint" {
  value       = aws_eks_cluster.cluster.endpoint
  description = "The endpoint of the EKS cluster"
}

output "cluster_ca" {
  value       = aws_eks_cluster.cluster.certificate_authority
  description = "The Certificate Authority of the EKS cluster"
}
