terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.37.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "terraform-foundations-udemy"
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "remote-state" {
  bucket = "tfstate-${data.aws_caller_identity.current.account_id}"

  tags = {
    Description = "Stores terraform remote state files"
    ManagedBy   = "Terraform"
    Owner       = "Danubia Carvalho"
    CreatedAt   = "2024-03-19"
  }
}

resource "aws_s3_bucket_versioning" "versioning-state" {
  bucket = aws_s3_bucket.remote-state.bucket

  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_dynamodb_table" "lock-table" {
  name           = "tflock-${aws_s3_bucket.remote-state.bucket}"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "remote_state_bucket" {
  value = aws_s3_bucket.remote-state.bucket
}

output "remote_state_bucket_arn" {
  value = aws_s3_bucket.remote-state.arn
}