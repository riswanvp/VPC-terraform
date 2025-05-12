
##VPC creation
resource "aws_vpc" "custom" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name       = "${var.project_name}-${var.env}"
    created_by = "Riswan"
  }
}

##Internet Gateway creation
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.custom.id
  tags = {
    Name = "${var.project_name}-${var.env}-IG"
  }
}

## Public Subnet creation
resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.custom.id
  cidr_block              = cidrsubnet(var.vpc_cidr, var.vpc_cidr_newbits, 0)
  availability_zone       = data.aws_availability_zones.current_AZ.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-${var.env}-public1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.custom.id
  cidr_block              = cidrsubnet(var.vpc_cidr, var.vpc_cidr_newbits, 1)
  availability_zone       = data.aws_availability_zones.current_AZ.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-${var.env}-public2"
  }
}

## Route table creation

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.custom.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = {
    Name = "${var.project_name}-${var.env}-Public-Rt"
  }
}

##Route table association

resource "aws_route_table_association" "pb1-association" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public-rt.id
}

##Private Subnet
resource "aws_subnet" "private1" {
  vpc_id                  = aws_vpc.custom.id
  availability_zone       = data.aws_availability_zones.current_AZ.names[0]
  cidr_block              = cidrsubnet(var.vpc_cidr, var.vpc_cidr_newbits, 2)
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.project_name}-${var.env}-private1"
  }
}
resource "aws_subnet" "private2" {
  vpc_id                  = aws_vpc.custom.id
  availability_zone       = data.aws_availability_zones.current_AZ.names[1]
  cidr_block              = cidrsubnet(var.vpc_cidr, var.vpc_cidr_newbits, 3)
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.project_name}-${var.env}-private2"
  }
}