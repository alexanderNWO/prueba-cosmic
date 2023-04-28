variable "rds_admin_username" {
  description = "Nombre de usuario para administrador de rds postgres"
  type = string
}

variable "rds_admin_password" {
  description = "Contraseña de usuario para administrador de rds postgres"
  type = string
}

variable "rds_database_name" {
  description = "RDS postgres database name"
  type        = string
}