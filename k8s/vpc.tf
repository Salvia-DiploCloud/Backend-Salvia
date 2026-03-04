data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  # Usamos las dos primeras AZs disponibles en la región.
  azs = slice(data.aws_availability_zones.available.names, 0, 2)
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"

  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr

  azs = local.azs

  # Subnets generadas automáticamente a partir del CIDR principal.
  # Puedes cambiarlas a valores explícitos si lo prefieres.
  private_subnets = [
    cidrsubnet(var.vpc_cidr, 4, 0),
    cidrsubnet(var.vpc_cidr, 4, 1),
  ]

  public_subnets = [
    cidrsubnet(var.vpc_cidr, 4, 2),
    cidrsubnet(var.vpc_cidr, 4, 3),
  ]

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    "kubernetes.io/role/elb"                     = "1"
    "kubernetes.io/cluster/${var.cluster_name}"  = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"            = "1"
    "kubernetes.io/cluster/${var.cluster_name}"  = "shared"
  }

  tags = {
    "Environment" = var.environment
    "Name"        = "${var.cluster_name}-vpc"
  }
}

