output "public_ip_address" {
  description = "The public IP address of the Ec2 instance."
  value = aws_instance.instance.public_ip
}