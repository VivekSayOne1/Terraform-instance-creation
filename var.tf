provider "aws" {
 secret_key = var.secret_key
 access_key = var.access_key
 region     = var.region
    
}
variable "secret_key" {
  description = "secret_key for aws"
}
variable "access_key" {
  description = "Access_key for aws"
}
variable "ami" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
 
}
variable "instance_type" {
  description = "aws instance type"
}
variable "key_name" {
  description = "aws key_name"
}
variable "region" {
  description = "aws instance region"
}

variable "availability_zone" {
  description = "aws availability_zone"
}
variable "sg_ingress_rules" {
  description = "Ingress security group rules"
  type        = map
}

