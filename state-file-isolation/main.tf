terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.55.0"
    }
  }
  backend "s3" {
    bucket         = "terraform-state-s3-example"
    # The filepath within the S3 bucket where the Terraform state file should be written.
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-state-example-locks"
    # Setting this to true ensures that your Terraform state will be encrypted on disk when stored in S3.
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-2"
}

# AWS S3 bucket to store terraform state file
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-s3-example"
  # Prevent accidental deletion of this S3 bucket
  #   lifecycle {
  #     prevent_destroy = true
  #   }
}

# Enable versioning so you can see the full revision history of your # state files
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Explicitly block all public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

# DynamoDB table to use for locking.
resource "aws_dynamodb_table" "tf_locks" {
  name         = "terraform-state-example-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}


output "s3_buket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of S3 bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.tf_locks.name
  description = "The name of the DynamoDB table"
}
