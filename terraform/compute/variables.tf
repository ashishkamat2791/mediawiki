variable "ami" {
}

variable "key_name" {
}

variable "public_key_path" {
}

variable "private_key_path" {
  
}

variable "web_instance_type" {
}

variable "web_security_group" {
}

variable "db_instance_type" {
}

variable "db_security_group" {
}

variable "db_root_password" {
  
}
variable "db_password" {
  default="mediawiki@123"
}


variable "web_subnet_a" {
}

variable "web_subnet_b" {
}

variable "db_subnet" {
}

variable "aws_profile" {
}

variable "aws_region" {
    default = "us-east-1"
  
}
