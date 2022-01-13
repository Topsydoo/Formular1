# configure vpc

resource "aws_vpc" "project7_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Project7_vpc"
  }
}


# configure private subnet1

resource "aws_subnet" "project7_priv_sub1" {
  vpc_id     = aws_vpc.project7_vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "project7_priv_sub1"
  }
}


# configure private subnet2

resource "aws_subnet" "project7_priv_sub2" {
  vpc_id     = aws_vpc.project7_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "project7_priv_sub2"
  }
}


# configure public subnet1

resource "aws_subnet" "project7_pub_sub1" {
  vpc_id     = aws_vpc.project7_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "project7_pub_sub1"
  }
}


# configure public subnet2

resource "aws_subnet" "project7_pub_sub2" {
  vpc_id     = aws_vpc.project7_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "project7_pub_sub2"
  }
}


# configure private route1

resource "aws_route_table" "project7_priv_rt1" {
  vpc_id = aws_vpc.project7_vpc.id

  route = []

  tags = {
    Name = "project7_priv_rt1"
  }
}


# configure private route2

resource "aws_route_table" "project7_priv_rt2" {
  vpc_id = aws_vpc.project7_vpc.id

  route = []

  tags = {
    Name = "project7_priv_rt2"
  }
}


# configure public route1

resource "aws_route_table" "project7_pub_rt1" {
  vpc_id = aws_vpc.project7_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project7_int_gtw.id
  }
}


# configure public route2

resource "aws_route_table" "project7_pub_rt2" {
  vpc_id = aws_vpc.project7_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project7_int_gtw.id
  }
}


# configure internet gateway

resource "aws_internet_gateway" "project7_int_gtw" {
  vpc_id = aws_vpc.project7_vpc.id

  tags = {
    Name = "project7-igw"
  }
}

# associate subnet with route table 

resource "aws_route_table_association" "pub_rt1_sub1" {
  subnet_id      = aws_subnet.project7_pub_sub1.id
  route_table_id = aws_route_table.project7_pub_rt1.id
}


# association of internet gateway to route table

resource "aws_route" "project7_igw_rt" {
  gateway_id     = aws_internet_gateway.project7_int_gtw.id
  route_table_id = aws_route_table.project7_pub_rt1.id
  destination_cidr_block = "0.0.0.0/0"
}