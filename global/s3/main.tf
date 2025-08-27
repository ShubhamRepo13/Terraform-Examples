provider "aws" {
  region = "ap-south-1"
}


terraform {
  backend "s3" {
    bucket         = "shubham-chavhan-s3-bucket-terraform-state"
    key            = "workspace/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "shubham-chavhan-terraform-locks"
    encrypt        = true
  }
}


resource "aws_s3_bucket" "example_s3_bucket_resource_block" {
  bucket = "shubham-chavhan-s3-bucket-terraform-state"

  tags = {
    Name = "shubham-chavhan-s3-bucket-terraform-state_tag"
  }
  # Prevents accidental deletion of this s3 bucket
  lifecycle {
    prevent_destroy = true
  }

}

# Enable versioning so you can see the full revision history of your
# state files
resource "aws_s3_bucket_versioning" "example_s3_bucket_versioning_resource_block" {
  bucket = aws_s3_bucket.example_s3_bucket_resource_block.id
  versioning_configuration {
    status = "Enabled"
  }
}

#Enable server-side encryption by default so that all objects stored in the bucket are encrypted
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.example_s3_bucket_resource_block.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Explicitly block all public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.example_s3_bucket_resource_block.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

# DynamoDB table to store the state locks
resource "aws_dynamodb_table" "example_dynamodb_table_resource_block" {

  name         = "shubham-chavhan-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

