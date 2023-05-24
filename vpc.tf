
resource "aws_vpc" "hjh-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "web_server_subnet" {
  vpc_id            = aws_vpc.hjh-vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-northeast-2a"

  map_public_ip_on_launch = true

  tags = {
    Name = "Web Server Subnet"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.hjh-vpc.id

  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "web_server_route_table" {
  vpc_id = aws_vpc.hjh-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "Web Server Route Table"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.web_server_subnet.id
  route_table_id = aws_route_table.web_server_route_table.id
}
