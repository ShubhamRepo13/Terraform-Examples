provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "Instance_creation" {
  ami                         = "ami-0861f4e788f5069dd"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.Demo-sg.id}"]
  associate_public_ip_address = true
  user_data                   = <<-EOF
#!/bin/bash
sudo yum install -y httpd
sudo  echo "Hello World" > sudo tee /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd
EOF

  tags = {
    Name = "MyFirstInstance"
  }


}

resource "aws_security_group" "Demo-sg" {
  name = "terraform-security-group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

