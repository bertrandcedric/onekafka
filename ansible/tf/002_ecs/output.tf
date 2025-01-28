output "instance_id_jumphost" {
  value = module.ec2_instance_jumphost.public_dns
}

output "instance_id_sample" {
  value = module.ec2_instance_sample.private_dns
}
