output "ec2_cosmic_armenta_public_ip" {
  description = "IP publica de EC2 con Docker"
  value       = aws_instance.cosmic_armenta_docker_instance.public_ip
}