resource "aws_s3_bucket" "this" {
  bucket = "${random_pet.bucket.id}-${var.environment}"

  tags = local.common_tags
}


resource "aws_s3_bucket" "import1" { #bucket importado da aws
  bucket = "import-terraform-aula16"
  tags = {
    Criado    = "12-03-2024"
    Importado = "12-03-2024"
    ManagedBy = "Terraform"
  }
}



resource "aws_s3_object" "this" {
  bucket = aws_s3_bucket.this.bucket
  key    = "config/${local.ip_filepath}" #path
  source = local.ip_filepath
  etag   = filemd5(local.ip_filepath)
}

