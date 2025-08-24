provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "Instance_creation" {
  ami                         = var.Ami_Id
  instance_type               = var.instance_type
  vpc_security_group_ids      = ["${aws_security_group.Demo-sg.id}"]
  associate_public_ip_address = true
  key_name                    = "${var.key_name}"
  user_data                   = <<-EOF
#!/bin/bash
yum install -y httpd
echo "Hello World" > /var/www/html/index.html
systemctl start httpd
systemctl enable httpd
EOF

  tags = {
    Name = "MyFirstInstance"
  }


}

resource "aws_security_group" "Demo-sg" {
  name = "terraform-security-group"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.SSH_port
    to_port     = var.SSH_port
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
output "instance_ip_addr" {
  value = aws_instance.Instance_creation.public_ip
}
