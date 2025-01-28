resource "local_file" "ansible_inventory_jumphost" {
  content = templatefile("${path.module}/${var.hosts_jumphost_templatefile}",
    {
      jumphost = module.ec2_instance_jumphost.*.public_dns
    }
  )
  filename        = var.inventory_jumphost_file
  file_permission = "664"
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/${var.hosts_templatefile}",
    {
      zookeepers           = var.deployment_type == "private" ? aws_instance.zookeepers.*.private_dns : aws_instance.zookeepers.*.public_dns
      kafka_controllers    = var.deployment_type == "private" ? aws_instance.controllers.*.private_dns : aws_instance.controllers.*.public_dns
      kafka_controller_azs = aws_instance.controllers.*.availability_zone
      kafka_brokers        = var.deployment_type == "private" ? aws_instance.brokers.*.private_dns : aws_instance.brokers.*.public_dns
      kafka_broker_azs     = aws_instance.brokers.*.availability_zone
      kafka_connects       = var.deployment_type == "private" ? aws_instance.connect.*.private_dns : aws_instance.connect.*.public_dns
      ksqls                = var.deployment_type == "private" ? aws_instance.ksql.*.private_dns : aws_instance.ksql.*.public_dns
      kafka_rests          = var.deployment_type == "private" ? aws_instance.rest.*.private_dns : aws_instance.rest.*.public_dns
      schema_registries    = var.deployment_type == "private" ? aws_instance.schema.*.private_dns : aws_instance.schema.*.public_dns
      control_centers      = var.deployment_type == "private" ? aws_instance.c3.*.private_dns : aws_instance.c3.*.public_dns
    }
  )
  filename        = var.inventory_file
  file_permission = "664"
}

resource "local_file" "hosts_json" {
  content = templatefile("${path.module}/${var.json_templatefile}",
    {
      zookeepers = [
        var.deployment_type == "private" ? aws_instance.zookeepers.*.private_dns : aws_instance.zookeepers.*.public_dns,
        aws_route53_record.zookeepers.*.name,
        aws_route53_record.zookeepers.*.fqdn,
      ]
      controllers = [
        var.deployment_type == "private" ? aws_instance.controllers.*.private_dns : aws_instance.controllers.*.public_dns,
        aws_route53_record.controllers.*.name,
        aws_route53_record.controllers.*.fqdn,
      ]
      kafka_brokers = [
        var.deployment_type == "private" ? aws_instance.brokers.*.private_dns : aws_instance.brokers.*.public_dns,
        aws_route53_record.brokers.*.name,
        aws_route53_record.brokers.*.fqdn,
      ]
      kafka_connects = [
        var.deployment_type == "private" ? aws_instance.connect.*.private_dns : aws_instance.connect.*.public_dns,
        aws_route53_record.connect.*.name,
        aws_route53_record.connect.*.fqdn,
      ]
      ksqls = [
        var.deployment_type == "private" ? aws_instance.ksql.*.private_dns : aws_instance.ksql.*.public_dns,
        aws_route53_record.ksql.*.name,
        aws_route53_record.ksql.*.fqdn,
      ]
      kafka_rests = [
        var.deployment_type == "private" ? aws_instance.rest.*.private_dns : aws_instance.rest.*.public_dns,
        aws_route53_record.rest.*.name,
        aws_route53_record.rest.*.fqdn,
      ]
      schema_registries = [
        var.deployment_type == "private" ? aws_instance.schema.*.private_dns : aws_instance.schema.*.public_dns,
        aws_route53_record.schema.*.name,
        aws_route53_record.schema.*.fqdn,
      ]
      control_centers = [
        var.deployment_type == "private" ? aws_instance.c3.*.private_dns : aws_instance.c3.*.public_dns,
        aws_route53_record.c3.*.name,
        aws_route53_record.c3.*.fqdn,
      ]
    }
  )
  filename        = var.json_file
  file_permission = "664"
}