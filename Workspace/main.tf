provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket         = "shubham-chavhan-s3-bucket-terraform-state"
    key            = "unique-workspace/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "shubham-chavhan-terraform-locks"
    encrypt        = true
  }
}

resource "aws_instance" "example_instance_resource_block" {
    ami = "ami-0861f4e788f5069dd"
    instance_type = "t2.micro"

    tags = {
      Name = "example_instance"
    }

}
