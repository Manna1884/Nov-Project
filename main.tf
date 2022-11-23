 #Configuring the Provider
provider "aws" {
  region = var.vpc_region

}


# Creating a VPC
resource "aws_vpc" "vpc-project" {
  cidr_block = var.cidr_block_vpc
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  enable_dns_support = "true"

tags = {
    Name = var.vpc_name
  }
}


#Creating Public Subnet 1
resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.vpc-project.id
  cidr_block = var.cidr_block_publicsub1
  availability_zone = var.availability_zone1

  tags = {
    Name = var.name_publicsub1
  }
}

#Creating Public Subnet 2
resource "aws_subnet" "public_subnet2" {
  vpc_id     = aws_vpc.vpc-project.id
  cidr_block = var.cidr_block_publicsub2
  availability_zone = var.availability_zone2

  tags = {
    Name = var.name_publicsub2
  }
}
#Creating Private Subnet 1
resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.vpc-project.id
  cidr_block = var.cidr_block_privatesub1
  availability_zone = var.availability_zone1

  tags = {
    Name = var.name_privatesub1
  }
}

#Creating Private Subnet 2
resource "aws_subnet" "private_subnet2" {
  vpc_id     = aws_vpc.vpc-project.id
  cidr_block = var.cidr_block_privatesub2
  availability_zone = var.availability_zone2

  tags = {
    Name = var.name_privatesub2
  }
}

#Creating Private Subnet 3
resource "aws_subnet" "private_subnet3" {
  vpc_id     = aws_vpc.vpc-project.id
  cidr_block = var.cidr_block_privatesub3
  availability_zone = var.availability_zone1

  tags = {
    Name = var.name_privatesub3
  }
}

#Creating Private Subnet 4
resource "aws_subnet" "private_subnet4" {
  vpc_id     = aws_vpc.vpc-project.id
  cidr_block = var.cidr_block_privatesub4
  availability_zone = var.availability_zone2

  tags = {
    Name = var.name_privatesub4
  }
}

#Creating Public Route table for Webserver Tier
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc-project.id

  tags = {
    Name = var.route_table_public
  }
}

#Creating Private Route table for Application Tier
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc-project.id

  tags = {
    Name = var.route_table_private
  }
}

#Creating Private Route table for Database Tier
resource "aws_route_table" "dbprivate_route_table" {
  vpc_id = aws_vpc.vpc-project.id

  tags = {
    Name = var.route_table_private2
  }
}

#Route Association Public1
resource "aws_route_table_association" "public-route-table-association1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

#Route Association Public2
resource "aws_route_table_association" "public-route-table-association2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}

#Route Association Private1
resource "aws_route_table_association" "private-route-table-association1" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_route_table.id
}

#Route Association Private2
resource "aws_route_table_association" "private-route-table-association2" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_route_table.id
}

#Route Association Private3
resource "aws_route_table_association" "private-route-table-association3" {
  subnet_id      = aws_subnet.private_subnet3.id
  route_table_id = aws_route_table.dbprivate_route_table.id
}

#Route Association Private4
resource "aws_route_table_association" "private-route-table-association4" {
  subnet_id      = aws_subnet.private_subnet4.id
  route_table_id = aws_route_table.dbprivate_route_table.id
}


#Creating Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-project.id

  tags = {
    Name = var.internet_gateway_name
  }
}

#Internet Gateway Route
resource "aws_route" "igw-route" {
  route_table_id            = aws_route_table.public_route_table.id
  gateway_id                = aws_internet_gateway.igw.id
  destination_cidr_block    = "0.0.0.0/0"

}

#Create Elastic IPs
resource "aws_eip" "zone2a_eip" {
  vpc                       = true
  associate_with_private_ip = "200.0.64.1"

# This eip is for availability zone eu-west-2a
tags = {
    Name = var.eip_name1
  }
}

resource "aws_eip" "zone2b_eip" {
  vpc                       = true
  associate_with_private_ip = "200.0.90.1"

# This eip is for availability zone eu-west-2b
tags = {
    Name = var.eip_name2
  }
}


#Create NAT Gateways for Internet Thru Public Subnets
resource "aws_nat_gateway" "zone2a_gw" {
  allocation_id = aws_eip.zone2a_eip.id
  subnet_id     = aws_subnet.public_subnet1.id

# This nat gateway is for availability zone eu-west-2a
  tags = {
    Name = var.nat_gw_name1
  }
}

resource "aws_nat_gateway" "zone2b_gw" {
  allocation_id = aws_eip.zone2b_eip.id
  subnet_id     = aws_subnet.public_subnet2.id

# This nat gateway is for availability zone eu-west-2b
  tags = {
    Name = var.nat_gw_name2
  }
}

# Route NAT GW with Private Route Tables
resource "aws_route" "nat_gw_association_private_rt1" {
  route_table_id         = aws_route_table.private_route_table.id
  nat_gateway_id         = aws_nat_gateway.zone2a_gw.id
  destination_cidr_block = "0.0.0.0/0"
}  

resource "aws_route" "nat_gw_association_private_rt2" {
  route_table_id         = aws_route_table.dbprivate_route_table.id
  nat_gateway_id         = aws_nat_gateway.zone2b_gw.id
  destination_cidr_block = "0.0.0.0/0"
}  

