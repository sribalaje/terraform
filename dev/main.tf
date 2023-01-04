provider "aws" {
    region = "us-east-1"
  }

module "myvpc" {
  source = "/module/root/vpc"
}

module "myec2" {
  source = "/module/root/ec2"
  vpcid = module.myvpc.vpcid
  subnetid = module.myvpc.subnetid
  subnet = [ "10.0.1.0/24", "10.0.2.0/24" ] 
  ins_type = "t2.micro"
}
