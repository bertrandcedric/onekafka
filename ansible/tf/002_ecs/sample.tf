module "ec2_instance_sample" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.prefix}-sample"

  instance_type          = var.instance_type
  key_name               = var.key_name
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.internal-access.id]
  subnet_id              = var.private_subnet_id[0]

  tags = var.tags
}
