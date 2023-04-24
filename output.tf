output "ec2_cosmic_armenta_ssh_connection" {
  description = "Conexión via ssh a instancia pública"
  value       = "ssh -i ${var.key_pair_name}.pem ubuntu@${aws_instance.cosmic_armenta_docker_instance.public_ip}"
}

output "rds_connection_host" {
  description = "Host de instancia con Postgres"
  value       = module.rds_postgres.rds_cosmic_armenta_public_host
}

output "rds_connection_port" {
  description = "Puerto de instancia con Postgres"
  value       = module.rds_postgres.rds_cosmic_armenta_port
}

output "rds_connection_username" {
  description = "Username de instancia con Postgres"
  value       = module.rds_postgres.rds_cosmic_armenta_username
}

output "rds_connection_password" {
  description = "Password de instancia con Postgres"
  value       = module.rds_postgres.rds_cosmic_armenta_password
  sensitive   = true
}
