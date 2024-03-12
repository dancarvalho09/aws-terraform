terraform {
    
  required_version = "1.6.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.37.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"
  profile = "terraform-foundations-udemy"
}


resource "aws_s3_bucket" "bucket-test-terraform" {
  bucket = "bucket-test-terraform942874928"
 
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}