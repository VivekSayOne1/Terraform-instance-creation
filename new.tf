provider "aws" {
  region = "ap-south-1"
  access_key = "AKIA4NUOTEE4P25T3WGY"
  secret_key = "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"
}
resource "aws_instance" "new-server" { 
  ami  = "ami-0851b76e8b1bce90b"
  instance_type ="t2.micro"
  tags  =   {
      Name = "new-server1"
}
}
