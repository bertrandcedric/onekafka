output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "vpc_id"
}

output "private_subnets" {
  value       = module.vpc.private_subnets
  description = "private_subnets"
}

output "public_subnets" {
  value       = module.vpc.public_subnets
  description = "public_subnets"
}

output "security_group" {
  value       = module.vpc.default_security_group_id
  description = "security_group"
}

output "hosted_zone_id" {
  value       = aws_route53_zone.private[0].id
  description = "security_group"
}
