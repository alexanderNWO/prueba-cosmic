resource "aws_security_group" "cosmic_armenta_rds_sg" {
  vpc_id      = data.aws_vpc.default_vpc_cosmic_armenta.id
  name        = "RDS instances SG"
  description = "Allow inbound traffic for postgres rds instance"
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "cosmic_armenta_rds" {
  allocated_storage    = 10
  db_name              = var.rds_database_name
  identifier           = "cosmic-armenta-db" 
  engine               = "postgres"
  engine_version       = "11.19"
  instance_class       = "db.t3.micro"
  username             = var.rds_admin_username
  password             = var.rds_admin_password
  publicly_accessible  = true
  skip_final_snapshot  = true
  vpc_security_group_ids = [ aws_security_group.cosmic_armenta_rds_sg.id ]
  tags = {
    "Name" = "RDS Instance - Cosmic - Dev - Armenta"
  }
}