resource "aws_security_group" "allow_count" {
  name        = "allow_count"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpcid

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

 ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_count"
  }
}

resource "aws_instance" "public" {
    ami           = "ami-0b5eea76982371e91"
    instance_type = var.ins_type
    vpc_security_group_ids =[ "${aws_security_group.allow_count.id}" ]
    count = length(var.subnet)
    subnet_id = var.subnetid[count.index]
    key_name = "Webserver"
    tags = {
      Name = "public"
    }
}
