module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.15.1"

  name               = var.cluster_name
  kubernetes_version = var.cluster_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Permite que el creador del cluster tenga permisos de admin en Kubernetes.
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    default = {
      instance_types = var.node_group_instance_types
      desired_size   = var.node_group_desired_size
      min_size       = var.node_group_min_size
      max_size       = var.node_group_max_size
      subnet_ids     = module.vpc.private_subnets
    }
  }

  tags = {
    "Environment" = var.environment
    "Name"        = var.cluster_name
  }
}


