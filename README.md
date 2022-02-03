# Terraform-instance-creation
instance creation using .tf script


created two files var.tf and terraform.tfvar
declared secret key and access key on var file and dclared ami value and key value also
security group defiend as ingress variable



output.tf file conatin module output data
vpc.tf is the child module of new.tf it contains the vpc and network details of an ec2
vpcvar.tf file contain availabilty variable declared in that file
