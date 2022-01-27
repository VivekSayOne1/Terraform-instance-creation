provider "aws" {
  region = "ap-south-1"
  access_key = "AKIA4NUOTEE4LO5A74XF"
  secret_key = "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"
}
resource "aws_instance" "new" {
  ami  = "ami-0851b76e8b1bce90b"
  instance_type ="t2.micro"
  tags  =   {
      Name = "new-server"
}
}
