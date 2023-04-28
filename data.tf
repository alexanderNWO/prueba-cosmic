data "template_file" "init" {
  template = file("scripts/userdata.sh")

  vars = {
    db_user     = var.rds_admin_username
    db_password = var.rds_admin_password
    db_hostname = module.rds_postgres.rds_cosmic_armenta_public_host
    db_database = var.rds_database_name
    db_port     = module.rds_postgres.rds_cosmic_armenta_port
    vue_app_url = var.acm_domain_name
  }
}