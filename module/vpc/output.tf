output "vpcid" {
  value = aws_vpc.prod-vpc.id
  
  
}
output "subnetid" {
  value = aws_subnet.subnet-demo.id
}
output "gatewayid" {
  value = aws_internet_gateway.terraform-gw
}
