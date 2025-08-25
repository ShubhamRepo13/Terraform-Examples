output "instance_ip_addr" {
  value = aws_instance.Instance_creation.public_ip
}
