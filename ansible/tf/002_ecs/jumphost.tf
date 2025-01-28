# jumphost
module "ec2_instance_jumphost" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.prefix}-jumphost"

  instance_type               = var.instance_type
  ami                         = data.aws_ami.selected.id
  key_name                    = var.key_name
  monitoring                  = true
  vpc_security_group_ids      = [aws_security_group.internal-access.id, aws_security_group.external-access.id]
  subnet_id                   = var.public_subnet_id[0]
  associate_public_ip_address = true

  tags = var.tags
}