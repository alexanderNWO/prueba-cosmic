resource "aws_security_group" "sg_public_instances_cosmic_armenta" {
  name        = "Public Instances SG"
  description = "Allow SSH, HTTP and HTTPS traffic for all public instances"
  vpc_id      = aws_vpc.vpc_cosmic_armenta_virginia.id

  dynamic "ingress" {
    for_each = var.ingress_ports_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Public Instances SG - ${local.sufix}"
  }
}

resource "aws_instance" "cosmic_armenta_docker_instance" {
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet_1.id
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.sg_public_instances_cosmic_armenta.id]
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    volume_size           = 10
    volume_type           = "gp3"
  }
  user_data = data.template_file.init.rendered

  tags = {
    "Name" = "Instancia publica - ${local.sufix}"
  }

  provisioner "local-exec" {
    command = "echo Instancia creada con la IP ${aws_instance.cosmic_armenta_docker_instance.public_ip} >> datos_instancia.txt"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo Instancia con IP ${self.public_ip} Destruida >> datos_instancia.txt"
  }
}
