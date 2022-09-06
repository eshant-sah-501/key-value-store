resource "aws_vpc" "Main" {
   cidr_block       = var.main_vpc_cidr
   instance_tenancy = "default"
 }

// Create Internet Gateway and attach it to VPC
 resource "aws_internet_gateway" "IGW" {
    vpc_id =  aws_vpc.Main.id
 }

// Create a Public Subnet
 resource "aws_subnet" "publicsubnet" {
   vpc_id =  aws_vpc.Main.id
   cidr_block = "${var.public_subnet_cidr}"
   availability_zone = "us-east-1a"
 }

// Create a Private Subnet
 resource "aws_subnet" "privatesubnet" {
   vpc_id =  aws_vpc.Main.id
   cidr_block = "${var.private_subnet_cidr}"
 }

// Route table for Public Subnet
 resource "aws_route_table" "PublicRT" {
    vpc_id =  aws_vpc.Main.id
         route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
     }
 }

// Route table Association with Public Subnet's
 resource "aws_route_table_association" "PublicRTassociation" {
    subnet_id = aws_subnet.publicsubnet.id
    route_table_id = aws_route_table.PublicRT.id
 }
