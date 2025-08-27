variable "aws_region_name" {
  description = "The aws region to create resources in "
  type        = string
  default     = "ap-south-1"

}

variable "server_port" {
  description = "The port on which the server will run"
  type        = number
  default     = 80

}

variable "cidr_blocks" {
  description = "values for cidr blocks"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "key_name" {
  description = "The name of the key pair to use for the instance"
  type        = string
  default     = "AwsLogin"

}

variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-0861f4e788f5069dd"

}

variable "instance_type" {
  description = "value for instance type"
  type        = string
  default     = "t2.micro"
}