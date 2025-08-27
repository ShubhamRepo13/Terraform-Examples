provider "aws" {
    region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket         = "shubham-chavhan-s3-bucket-terraform-state"
    key            = "stage/data-store/mysql/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "shubham-chavhan-terraform-locks"
    encrypt        = true
  }
}

resource "aws_db_instance" "example_db_block"{
   identifier_prefix = "mysql-db-instance"
   engine = "mysql"
   instance_class = "db.t3.micro" 
   #engine_version = "8.0.28"
   allocated_storage = 10
   db_name = "mysql_db"
   skip_final_snapshot = true

   username = var.db_username
   password = var.db_password

}