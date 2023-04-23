resource "aws_vpc" "vpc_cosmic_armenta_virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    "Name" : "VPC - ${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_cosmic_armenta_virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    "Name" : "Public subnet - ${local.sufix}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_cosmic_armenta_virginia.id
  cidr_block = var.subnets[1]
  tags = {
    "Name" : "Private subnet - ${local.sufix}"
  }
  depends_on = [
    aws_subnet.public_subnet
  ]
}

resource "aws_internet_gateway" "igw_cosmic_armenta" {
  vpc_id = aws_vpc.vpc_cosmic_armenta_virginia.id

  tags = {
    Name = "IGW - ${local.sufix}"
  }
}

resource "aws_route_table" "route_table_public_cosmic_armenta" {
  vpc_id = aws_vpc.vpc_cosmic_armenta_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_cosmic_armenta.id
  }

  tags = {
    Name = "Public route table - ${local.sufix}"
  }
}

resource "aws_route_table_association" "route_table_association_public_cosmic_armenta" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route_table_public_cosmic_armenta.id
}

module "rds_postgres" {
  source             = "./modules/rds"
  rds_admin_username = var.rds_admin_username
  rds_admin_password = var.rds_admin_password
}

module "ec2_key_pair" {
  source = "./modules/ec2_key_pair"
}

output "rds_public_host" {
  value = module.rds_postgres.rds_cosmic_armenta_public_host
}