provider "aws" {
  region = var.aws_region_name
}

# Get default VPC 
data "aws_vpc" "default" {
  default = true
}

# Get subnet for ap-south-1a
data "aws_subnet" "subnet_a" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  filter {
    name   = "availability-zone"
    values = ["ap-south-1a"]
  }
}

# Get subnet for ap-south-1b
data "aws_subnet" "subnet_b" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  filter {
    name   = "availability-zone"
    values = ["ap-south-1b"]
  }
}

resource "aws_launch_template" "ASG_Launch_Template" {
  name_prefix            = "ASG_Launch_Template"
  image_id               = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = ["${aws_security_group.ASG_SG.id}"]
  key_name               = var.key_name

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ASG_Instance"
    }
  }
  user_data = base64encode(<<-EOF
#!/bin/bash
yum install -y httpd
echo "Hello World" > /var/www/html/index.html
systemctl start httpd
systemctl enable httpd
EOF
  )
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "ASG_SG" {
  name        = "ASG_Security_Group"
  description = "Security group for Auto Scaling Group"
  vpc_id      = data.aws_vpc.default.id
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  ingress {
    description = "Allow HTTP"
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_blocks
  }

  lifecycle {
    create_before_destroy = true
  }

}

#Auto Scaling Group
resource "aws_autoscaling_group" "example_asg" {
  name             = "example_asg_group"
  desired_capacity = 2
  min_size         = 1
  max_size         = 2
  vpc_zone_identifier = [data.aws_subnet.subnet_a.id, #ap-south-1a
    data.aws_subnet.subnet_b.id                       #ap-south-1b 
  ]

  launch_template {
    id      = aws_launch_template.ASG_Launch_Template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "example_asg_instance"
    propagate_at_launch = true
  }
}