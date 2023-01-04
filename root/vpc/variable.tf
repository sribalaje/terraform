variable "vpc_id" {
  default =  "10.0.0.0/16" 
}

variable "subnet" {
  default = [ "10.0.1.0/24", "10.0.2.0/24" ]
}

variable "az" {
 default = [ "us-east-1c", "us-east-1d" ]
}

