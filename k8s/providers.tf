terraform {
  required_version = ">= 1.5.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0.0"
    }
  }

  # Backend remoto en S3 (opcional).
  # No se activa hasta que descomentes este bloque y hayas creado
  # el bucket/tabla usando `backend-bootstrap.tf`.
  #
  # backend "s3" {
  #   bucket         = var.tf_state_bucket
  #   key            = var.tf_state_key
  #   region         = var.aws_region
  #   dynamodb_table = var.tf_state_dynamodb_table
  #   encrypt        = true
  # }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

