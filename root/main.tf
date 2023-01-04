provider "aws" {
    region = "us-east-1"
  }

resource "aws_vpc" "main_vpc" {
  cidr_block       = var.vpc_id
  instance_tenancy = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "main"
  }
}


#Public subnet 

resource "aws_subnet" "public_subnet" {
  
  vpc_id      = aws_vpc.main_vpc.id
  count = length(var.subnet)
  cidr_block = var.subnet[count.index]
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "public_subnet"
  }
}
#Internet Gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Internet Gateway"
  }
}


resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}
resource "aws_route_table_association" "public_association" {
  
  subnet_id = var.subnetid
  route_table_id = aws_route_table.public_route.id
}


variable "vpc_id" {
  default =  "10.0.0.0/16" 
}

variable "subnet" {
  default = [ "10.0.1.0/24", "10.0.2.0/24" ]

}

variable "subnetid" {
default = ""
}

output "subnet_out" {
   description =  "output"
   value = aws_subnet.public_subnet[*].id
}
