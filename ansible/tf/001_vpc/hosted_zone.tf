resource "aws_route53_zone" "private" {
  count = var.enable_private_dns ? 1 : 0
  name  = var.private_domain

  vpc {
    vpc_id = module.vpc.vpc_id
  }

  tags = var.tags
}
