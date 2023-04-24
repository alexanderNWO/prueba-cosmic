output "rds_cosmic_armenta_public_host" {
    description = "Host de instancia con Postgres"
    value = "Hostname: ${aws_db_instance.cosmic_armenta_rds.address}"
}

output "rds_cosmic_armenta_port" {
    description = "Puerto de instancia con Postgres"
    value = "Port: ${aws_db_instance.cosmic_armenta_rds.port}"
}

output "rds_cosmic_armenta_username" {
    description = "Username de instancia con Postgres"
    value = "Username: ${aws_db_instance.cosmic_armenta_rds.username}"
}

output "rds_cosmic_armenta_password" {
    description = "Password de instancia con Postgres"
    value = "Password: ${aws_db_instance.cosmic_armenta_rds.password}"
    sensitive = true
}
