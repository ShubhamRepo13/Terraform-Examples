output "s3_bucket_arn" {
    value = aws_s3_bucket.example_s3_bucket_resource_block.arn
    description = "The ARN of the S3 bucket"
  
}

output "dynamodb_table_name" {
    value = aws_dynamodb_table.example_dynamodb_table_resource_block.name
    description = "The name of the DynamoDB table"
  
}