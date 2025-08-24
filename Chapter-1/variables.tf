variable "server_port" {
  description = "Port on which the server will listen"
  type        = number
  default     = 80
}

variable "SSH_port" {
  description = "Port for SSH access"
  type        = number
  default     = 22
  
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type= string
  default = "t2.micro"
}

variable "Ami_Id" {
  description = "AMI ID for the EC2 instance"
  type = string
  default = "ami-0861f4e788f5069dd"
}

variable "key_name" {
  description = "key pair name for ssh access"
  type = string
  default = "AwsLogin"
}