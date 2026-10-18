
resource "aws_security_group" "kubernetes_lab" {
  name        = "nexvion-kubernetes-lab-sg"
  description = "Security group for Kubernetes lab"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from Jenkins EC2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.jenkins_private_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "nexvion-kubernetes-lab-sg"
    Project = "Nexvion"
  }
}

resource "aws_instance" "kubernetes_lab" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.kubernetes_lab.id]
  associate_public_ip_address = true
  key_name                    = var.key_pair_name

  root_block_device {
    volume_size = 25
    volume_type = "gp3"
  }

  tags = {
    Name    = "nexvion-kubernetes-lab"
    Project = "Nexvion"
  }
}

