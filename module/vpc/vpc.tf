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
