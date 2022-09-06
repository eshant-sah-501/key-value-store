# RSA key of size 4096 bits
resource "tls_private_key" "rsa_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "foo" {
    content  = tls_private_key.rsa_key.private_key_pem
    filename = "assignmentPrivateKey"
}

resource "aws_key_pair" "assignment_key_pair" {
  key_name   = "assignment-key-pair"
  public_key = tls_private_key.rsa_key.public_key_openssh
}


resource "aws_security_group" "sg" {
  description = "Flask App sg"
  vpc_id      = aws_vpc.Main.id
  dynamic "ingress" {
    for_each = var.security_groups
    content {
      description = ingress.value["name"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "instance" {
  ami                         = var.ec2.os_type == "linux" ? var.linux_ami : var.ubuntu_ami
  availability_zone           = var.ec2.availability_zone
  instance_type               = var.ec2.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.publicsubnet.id
  key_name                    = aws_key_pair.assignment_key_pair.id
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    volume_size           = var.ec2.volume_size
    volume_type           = var.ec2.volume_type
  }
  user_data = file("../scripts/${var.ec2.os_type}.sh")
}
























