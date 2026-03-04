/*
  Backend remoto de Terraform (S3 + DynamoDB)
  -------------------------------------------

  Este fichero se usa para crear el bucket S3 y la tabla DynamoDB que
  servirán como backend remoto del estado de Terraform.

  Flujo recomendado:
    1. Rellena tf_state_bucket y tf_state_dynamodb_table en tu terraform.tfvars.
    2. Ejecuta:
         terraform init
         terraform plan -target=aws_s3_bucket.tf_state -target=aws_dynamodb_table.tf_state_lock
         terraform apply -target=aws_s3_bucket.tf_state -target=aws_dynamodb_table.tf_state_lock
    3. Una vez creados, descomenta el bloque backend "s3" en providers.tf
       y vuelve a ejecutar `terraform init` para migrar el estado al bucket.
*/

resource "aws_s3_bucket" "tf_state" {
  count  = var.tf_state_bucket != "" ? 1 : 0
  bucket = var.tf_state_bucket

  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    "Name"        = "${var.cluster_name}-tf-state"
    "Environment" = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "tf_state" {
  count                   = var.tf_state_bucket != "" ? 1 : 0
  bucket                  = aws_s3_bucket.tf_state[0].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "tf_state_lock" {
  count        = var.tf_state_dynamodb_table != "" ? 1 : 0
  name         = var.tf_state_dynamodb_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    "Name"        = "${var.cluster_name}-tf-locks"
    "Environment" = var.environment
  }
}

