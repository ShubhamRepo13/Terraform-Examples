output "address" {
  value       = aws_db_instance.example_db_block.address
  description = "The address of the MySQL database"
  
}

output "port" {
  value       = aws_db_instance.example_db_block.port
  description = "The port of the MySQL database"
  
}