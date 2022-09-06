main_vpc_cidr = "10.0.0.0/24"
public_subnet_cidr = "10.0.0.128/26"
private_subnet_cidr = "10.0.0.192/26"
region = "us-east-1"
ec2 = {
    instance_type = "t2.micro"
    name = "flaskApp"
    os_type = "linux"
    volume_size = 20
    volume_type = "gp3"
    availability_zone = "us-east-1a"
  }
security_groups = [
//  {
//  from_port   = 22
//  name        = "SSH access"
//  protocol    = "tcp"
//  to_port     = 22
//  cidr_blocks = ["45.119.15.185/32"]  # IP address of device  for ssh
//  },
  {
  from_port   = 5000
  name        = "Flask app Port"
  protocol    = "tcp"
  to_port     = 5000
  cidr_blocks = ["0.0.0.0/0"]
}]

