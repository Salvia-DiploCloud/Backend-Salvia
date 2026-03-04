variable "aws_region" {
  description = "Región de AWS donde se desplegará el cluster EKS."
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "Perfil de credenciales de AWS a usar (coincide con tu configuración de AWS CLI)."
  type        = string
  default     = "default"
}

variable "cluster_name" {
  description = "Nombre del cluster de EKS."
  type        = string
  default     = "salvia-eks"
}

variable "cluster_version" {
  description = "Versión de Kubernetes para el cluster de EKS."
  type        = string
  default     = "1.30"
}

variable "vpc_cidr" {
  description = "CIDR principal de la VPC donde correrá el cluster."
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "Etiqueta de entorno (por ejemplo, dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "node_group_instance_types" {
  description = "Lista de tipos de instancia para el node group gestionado de EKS."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_group_desired_size" {
  description = "Número deseado de nodos en el node group gestionado."
  type        = number
  default     = 2
}

variable "node_group_min_size" {
  description = "Número mínimo de nodos en el node group gestionado."
  type        = number
  default     = 1
}

variable "node_group_max_size" {
  description = "Número máximo de nodos en el node group gestionado."
  type        = number
  default     = 4
}

variable "tf_state_bucket" {
  description = "Nombre del bucket S3 para el estado remoto de Terraform (si se usa). Debe ser único en toda AWS."
  type        = string
  default     = ""
}

variable "tf_state_key" {
  description = "Ruta (key) dentro del bucket S3 para el fichero de estado de Terraform."
  type        = string
  default     = "eks/terraform.tfstate"
}

variable "tf_state_dynamodb_table" {
  description = "Nombre de la tabla DynamoDB usada para el locking del estado remoto de Terraform (si se usa)."
  type        = string
  default     = ""
}

