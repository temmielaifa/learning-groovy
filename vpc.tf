provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}


terraform {
  backend "s3" {
    bucket = "cheche-bucket"
    key    = "dev/tfstate"
    region = "us-east-1"
  }
}







resource "aws_vpc" "che-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "che-vpc"
  }
}

resource "aws_subnet" "che-subnet" {
  vpc_id     = aws_vpc.che-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "che-subnet"
  }
}

resource "aws_internet_gateway" "che-igw" {
  vpc_id = aws_vpc.che-vpc.id

  tags = {
    Name = "che-igw"
  }
}


resource "aws_route_table" "che-rtb" {
  vpc_id = aws_vpc.che-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.che-igw.id
  }

#  route {
 #   ipv6_cidr_block        = "::/0"
  #  egress_only_gateway_id = aws_egress_only_internet_gateway.che-igw.id
#  }

  tags = {
    Name = "che-rtb"
  }
}
