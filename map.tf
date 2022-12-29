provider "aws" {
  region = var.regions
}

variable "regions" {
  default = "ap-south-1"
}

variable "mapping" {
  type = map
  default = {
    us-east-1 = "ami-0b5eea76982371e91",
    us-east-2 = "ami-0a606d8395a538502",
    ap-south-1 = "ami-0cca134ec43cf708f"
}
}

variable "zone" {
  default = {
  us-east-1 = "us-east-1a"
  us-east-2 = "us-east-2c"
  ap-south-1 = "ap-south-1b"  
}
}


resource "aws_instance" "terraform_ec2" {
  ami = "${lookup(var.mapping,var.regions)}"
  instance_type  = "t2.micro"
  availability_zone = "${lookup(var.zone,var.regions)}"
  tags = {
    Name = "mumbai"
  }
}

