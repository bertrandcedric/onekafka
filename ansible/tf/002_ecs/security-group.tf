locals {
  security_groups = {
    private = [aws_security_group.internal-access.id]
    public  = [aws_security_group.internal-access.id, aws_security_group.external-access.id]
  }

  subnet_ids = {
    private = var.private_subnet_id
    public  = var.public_subnet_id
  }
}

resource "aws_security_group" "external-access" {
  name        = var.external_security_group_name
  description = "Allows free traffic from a specific IP"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow all access from a specific host"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [local.my_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_security_group" "internal-access" {
  name        = var.internal_security_group_name
  description = "Allows internal traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow all access"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}
