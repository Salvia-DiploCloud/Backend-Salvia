output "cluster_name" {
  description = "Nombre del cluster de EKS."
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint del API server del cluster de EKS."
  value       = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "Certificado CA del cluster de EKS (Base64)."
  value       = module.eks.cluster_certificate_authority_data
}

output "cluster_arn" {
  description = "ARN del cluster de EKS."
  value       = module.eks.cluster_arn
}

output "vpc_id" {
  description = "ID de la VPC donde corre el cluster."
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "IDs de las subnets privadas usadas por los nodos del cluster."
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "IDs de las subnets públicas de la VPC."
  value       = module.vpc.public_subnets
}

