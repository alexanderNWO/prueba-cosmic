output "rds_cosmic_armenta_public_host" {
    description = "Host de RDS con Postgres"
    value = aws_db_instance.cosmic_armenta_rds.address
}
