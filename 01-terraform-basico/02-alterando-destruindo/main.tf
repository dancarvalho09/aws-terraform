terraform {

  required_version = "1.6.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.37.0"
    }
  }
}


provider "aws" {
  region  = "us-east-1"
  profile = "terraform-foundations-udemy"
}


resource "aws_s3_bucket" "bucket-test-terraform" {
  bucket = "bucket-test-terraform94287492899999"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
    ManagedBy   = "Danubia Carvalho"
    UpdateAt    = "2024-02-20"
  }
}