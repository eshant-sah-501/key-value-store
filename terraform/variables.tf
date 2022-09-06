variable "ubuntu_ami" {
  description = "ubuntu ami"
  type        = string
  default     = "ami-052efd3df9dad4825"
}

variable "linux_ami" {
  description = "linux ami"
  type        = string
  default     = "ami-05fa00d4c63e32376"
}

variable "security_groups" {
  description = "The attribute of security_groups information"
  type = list(object({
    name        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "ec2" {
  description = "The attribute of EC2 information"
  type = object({
    name = string
    os_type = string
    instance_type = string
    volume_size = number
    volume_type = string
    availability_zone = string
  })
}
variable "region" {
    description = "The attribute of EC2 information"
    type = string
}

variable "main_vpc_cidr" {
  description = "The attribute of EC2 information"
  type = string
}

variable "public_subnet_cidr" {
  description = "CIDR block of public subnets"
  type = string
}

variable "private_subnet_cidr" {
  description = "CIDR block of private subnet"
  type = string
}

