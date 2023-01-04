output "subnetid" {
   description =  "Display Subnet ID"
   value = aws_subnet.public_subnet[*].id
}

output "vpcid" {
  value = aws_vpc.main_vpc.id
}
