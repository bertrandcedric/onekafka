# Route53 records for Zookeeper
resource "aws_route53_record" "zookeepers" {
  count           = (var.zk_count > 0 && var.hosted_zone_id != null) ? var.zk_count : 0
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "zookeeper-${count.index}.${var.dns_suffix}"
  type            = "A"
  ttl             = "300"
  records         = [aws_instance.zookeepers.*.private_ip[count.index]]
}

# Route53 records for Controller
resource "aws_route53_record" "controllers" {
  count           = (var.controller_count > 0 && var.hosted_zone_id != null) ? var.controller_count : 0
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "controller-${count.index}.${var.dns_suffix}"
  type            = "A"
  ttl             = "300"
  records         = [aws_instance.controllers.*.private_ip[count.index]]
}

# Route53 records for Broker
resource "aws_route53_record" "brokers" {
  count           = (var.broker_count > 0 && var.hosted_zone_id != null) ? var.broker_count : 0
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "broker-${count.index}.${var.dns_suffix}"
  type            = "A"
  ttl             = "300"
  records         = [aws_instance.brokers.*.private_ip[count.index]]
}

# Route53 records for Connect
resource "aws_route53_record" "connect" {
  count           = (var.connect_count > 0 && var.hosted_zone_id != null) ? var.connect_count : 0
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "connect-${count.index}.${var.dns_suffix}"
  type            = "A"
  ttl             = "300"
  records         = [aws_instance.connect.*.private_ip[count.index]]
}

# Route53 records for Schema
resource "aws_route53_record" "schema" {
  count           = (var.schema_count > 0 && var.hosted_zone_id != null) ? var.schema_count : 0
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "schema-${count.index}.${var.dns_suffix}"
  type            = "A"
  ttl             = "300"
  records         = [aws_instance.schema.*.private_ip[count.index]]
}

# Route53 records for C3
resource "aws_route53_record" "c3" {
  count           = (var.c3_count > 0 && var.hosted_zone_id != null) ? var.c3_count : 0
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "c3-${count.index}.${var.dns_suffix}"
  type            = "A"
  ttl             = "300"
  records         = [aws_instance.c3.*.private_ip[count.index]]
}

# Route53 records for KSQL
resource "aws_route53_record" "ksql" {
  count           = (var.ksql_count > 0 && var.hosted_zone_id != null) ? var.ksql_count : 0
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "ksql-${count.index}.${var.dns_suffix}"
  type            = "A"
  ttl             = "300"
  records         = [aws_instance.ksql.*.private_ip[count.index]]
}

# Route53 records for REST
resource "aws_route53_record" "rest" {
  count           = (var.rest_count > 0 && var.hosted_zone_id != null) ? var.rest_count : 0
  allow_overwrite = true
  zone_id         = var.hosted_zone_id
  name            = "rest-${count.index}.${var.dns_suffix}"
  type            = "A"
  ttl             = "300"
  records         = [aws_instance.rest.*.private_ip[count.index]]
}