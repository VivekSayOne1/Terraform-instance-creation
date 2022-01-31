provider "aws" {
    secret_key = var.secret_key
    access_key = var.access_key
    region =   "ap-south-1"
    
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
