#creating vpc
resource "aws_vpc" "Nginx1" {
 cidr_block = var.cidr

  tags = {
    Name= "Nginx1"
  }
}

#creating subnet
resource "aws_subnet" "Nginx1_subnet" {
  vpc_id = aws_vpc.Nginx1
  cidr_block = var.Nginx1_subnet_cidr
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true

 tags = { 
  Name = "Nginx1_subnet"
 }
}

#creating Internet gate way

resource "aws_internet_gateway" "Nginx1_igw" {
 vpc_id = aws_vpc.Nginx1_vpc

 tags = {
  Name = "Nginx1_igw"
 }
}

#creating route table
resource "aws_route_table" "Nginx1_route_table" {
 vpc_id = aws_vpc.Nginx1_vpc

 tags = { 
  Name = "Nginx1_route_table"
 }
}

#creating route
resource "aws_route" "Nginx1_route" {
 cidr_block = 0.0.0.0/0
 gate_way_id = aws_internet_gateway_id.Nginx_igw
}

#creating route table association
resource "aws_route_table_association" "Nginx1_public_asso" {
 subnet_id = aws_subnet.Nginx1_subnet
 route_table_id = aws_route_table.Nginx1_route_table
}

 
