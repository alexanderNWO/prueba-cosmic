variable "virginia_cidr" {
  description = "CIDR Red para vpc de virginia"
  type        = string
  sensitive   = false
}

variable "subnets" {
  description = "Lista de subnets"
  type        = list(string)
}

variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)
}

variable "sg_ingress_cidr" {
  description = "CIDR for ingress sg traffic"
  type        = string
}

variable "ec2_specs" {
  description = "Especificaciones para EC2"
  type        = map(string)
}

variable "ingress_ports_list" {
  description = "Lista de puertos inboud"
  type        = list(number)
}

variable "access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "secret_key" {
  description = "AWS Secret Key"
  type        = string
}

variable "rds_admin_username" {
  description = "RDS admin username"
  type        = string
}

variable "rds_admin_password" {
  description = "RDS admin password"
  type        = string
}