resource "aws_vpc" "vpc_cosmic_armenta_virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    "Name" : "VPC - ${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.vpc_cosmic_armenta_virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    "Name" : "Public subnet - ${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.vpc_cosmic_armenta_virginia.id
  cidr_block              = var.subnets[1]
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    "Name" : "Public subnet - ${local.sufix}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_cosmic_armenta_virginia.id
  cidr_block = var.subnets[2]
  tags = {
    "Name" : "Private subnet - ${local.sufix}"
  }
  depends_on = [
    aws_subnet.public_subnet_1,
    aws_subnet.public_subnet_2
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

resource "aws_route_table_association" "route_table_association_public_cosmic_armenta_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.route_table_public_cosmic_armenta.id
}

resource "aws_route_table_association" "route_table_association_public_cosmic_armenta_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.route_table_public_cosmic_armenta.id
}

module "rds_postgres" {
  source             = "./modules/rds"
  rds_admin_username = var.rds_admin_username
  rds_admin_password = var.rds_admin_password
}

module "ec2_key_pair" {
  source        = "./modules/ec2_key_pair"
  key_pair_name = var.key_pair_name
}

module "acm_request_certificate" {
  source = "cloudposse/acm-request-certificate/aws"
  # Cloud Posse recommends pinning every module to a specific version
  version                           = "0.17.0"
  domain_name                       = "prueba.noticiasultimahora.mx"
  process_domain_validation_options = true
  ttl                               = "300"
}

module "production_www" {
  source = "cloudposse/route53-alias/aws"
  # Cloud Posse recommends pinning every module to a specific version
  version          = "0.13.0"
  aliases          = ["prueba.noticiasultimahora.mx"]
  parent_zone_name = "noticiasultimahora.mx"
  target_dns_name  = aws_lb.LB_Cosmic_Armenta.dns_name
  target_zone_id   = aws_lb.LB_Cosmic_Armenta.zone_id
}