#creating vpc
resource "aws_vpc" "Nginx1" {
 cidr_block = var.vpc_cidr

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
 vpc_id = aws_vpc.Nginx1

 tags = {
  Name = "Nginx1_igw"
 }
}

#creating route table
resource "aws_route_table" "Nginx1_route_table" {
 vpc_id = aws_vpc.Nginx1

 tags = { 
  Name = "Nginx1_route_table"
 }
}

#creating route
resource "aws_route" "Nginx1_route" {
 cidr_block = "0.0.0.0/0"
 route_table_id = aws_route_table.Nginx1_route_table
 gateway_id = aws_internet_gateway_id.Nginx_igw
}

#creating route table association
resource "aws_route_table_association" "Nginx1_public_asso" {
 subnet_id = aws_subnet.Nginx1_subnet
 route_table_id = aws_route_table.Nginx1_route_table
}

#creating security group

resource "aws_security_group" "Nginx1_sg" {
 Name = "Nginx1_sg"
 description = "allow HTTP and SSH"
 vpc_id = aws_vpc.Nginx1

ingress {
description = "Allow SSH port"
from_port = 22
to_port = 22
protocol = "tcp"
cidr_block = ["0.0.0.0/0"]
}

ingress {
description = "allow Http port"
from_port = 80
to_port = 80
protocol = "tcp"
cidr_block = ["0.0.0.0/0"]
}

egress {
description = "allow all outbound"
from_port = 0
to_port = 0
protocol = "-1"
cidr_block = ["0.0.0.0/0"]
}

 tags = {
  Name = "Nginx1_sg"
 }
}



#--------------------------------
#--------------------------------

#creating EC2
resource "aws_instance" "Nginx1_ec2" {
 instance_type = var.instance_type
 ami           = var.ami_id
 subnet_id     = aws_subnet.Nginx1_subnet
 key_name      = var.key_name
 security_groups = [aws.security_group.Nginx1_sg]

 user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              echo "<h1>Welcome to Nginx1!</h1><p>Deployed via Terraform 🚀</p>" > /var/www/html/index.nginx-debian.html
              systemctl enable nginx
              systemctl start nginx
              EOF

  tags = {
    Name = "Nginx1_ec2"
  }
}




 
