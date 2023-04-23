resource "aws_key_pair" "cosmic-key-pair" {
  key_name   = "cosmic-armenta"
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "cosmic-key" {
  content         = tls_private_key.rsa.private_key_pem
  filename        = "./keys/cosmic-armenta.pem"
  file_permission = "0400"
}
