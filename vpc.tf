
#creating vpc
resource "aws_vpc" "main-vpc" {
    cidr_block = "10.0.0.0/16"

    enable_dns_support   = true
    enable_dns_hostnames = true
    
    tags = {
        Name = "main-vpc"
    }
}

#creating public subnet
resource "aws_subnet" "pb-subnet-1" {
    vpc_id = aws_vpc.main-vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone_id = "use1-az1"
    tags = {
        Name = "pb-subnet-1"
    }
}


#creating internet_gateway
resource "aws_internet_gateway" "pb-igw" {
    vpc_id = aws_vpc.main-vpc.id
    tags = {
        Name = "pb-igw"
    }
}


#creating security groups
resource "aws_security_group" "main-SG" {
    name = "main-SG"
    description = "security group for the main vpc"
    vpc_id = aws_vpc.main-vpc.id

    tags = {
        Name = "main-SG"
    }
}


#creating inbound rules
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
     
    for_each = var.ingress_ports

    security_group_id = aws_security_group.main-SG.id
    cidr_ipv4 = "0.0.0.0/0"
    
    from_port = each.value
    to_port = each.value
    ip_protocol = "tcp"

    tags = {
        Name = each.key
    }
}

#creating outbound rules
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.main-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


#creating route tables and assosiation
resource "aws_route_table" "pb-route-table" {
  vpc_id = aws_vpc.main-vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.pb-igw.id
  }

  tags = {
      Name = "pb-route-table"
  }
}

resource "aws_route_table_association" "pb-sub-asso" {
  subnet_id = aws_subnet.pb-subnet-1.id
  route_table_id = aws_route_table.pb-route-table.id

}

