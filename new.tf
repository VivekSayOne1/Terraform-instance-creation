resource "aws_instance" "new-server" { 
  ami  = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  
   

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.Terraform-web-nic.id
  }
  user_data = <<-EOF
             #!/bin/bash
             sudo apt-get update && sudo apt-get upgrade -y
             sudo apt-get install nginx -y
             sudo systemctl enable nginx
             sudo systemctl start nginx
             sudo bash -c 'echo hello world > /var/www/html/index.html'
             EOF
          tags = {
            Name = "tf-instance"
          }
}
resource "aws_vpc" "prod-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "new-vpc"
  }
}
resource "aws_subnet" "subnet-demo" {
  vpc_id  = aws_vpc.prod-vpc.id
  cidr_block = "10.0.1.0/24"
   availability_zone = var.availability_zone


  tags = {
    Name = "new-subnet"
}
}
resource "aws_internet_gateway" "terraform-gw" {
  vpc_id = aws_vpc.prod-vpc.id
}
resource "aws_route_table" "terraform-route-table" {
vpc_id = aws_vpc.prod-vpc.id 
route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.terraform-gw.id
}
}
resource "aws_route_table_association" "terra-asso" {
  subnet_id = aws_subnet.subnet-demo.id
  route_table_id = aws_route_table.terraform-route-table.id
 
}
resource "aws_security_group" "terraform-security-gp" {
   name        = "Terraform-sg" 
   description = "Allow web inbound traffic"
   vpc_id = aws_vpc.prod-vpc.id


  dynamic "ingress" {
    for_each = var.sg_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }
egress {
  from_port  = 0
  to_port    = 0
  protocol   = "-1"
  cidr_blocks = ["0.0.0.0/0"]

}
tags = {
  Name ="terraform-new"
}
}
resource "aws_network_interface" "Terraform-web-nic" {
  subnet_id = aws_subnet.subnet-demo.id
  private_ips = ["10.0.1.50"]
  security_groups = [aws_security_group.terraform-security-gp.id]
  
}
resource "aws_eip" "tf-eip" {
  vpc        = true
  network_interface = aws_network_interface.Terraform-web-nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [aws_internet_gateway.terraform-gw]
}

