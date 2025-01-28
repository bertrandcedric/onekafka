# Instances EC2 Zookeeper
resource "aws_instance" "zookeepers" {
  count         = var.zk_count
  ami           = data.aws_ami.selected
  instance_type = var.zk_instance_type
  key_name      = var.key_name

  root_block_device {
    volume_size = 50
    encrypted   = true
  }

  tags = {
    Name         = "${var.dns_suffix}-zookeeper-${count.index}"
    description  = "zookeeper nodes - Managed by Terraform"
    role         = "zookeeper"
    zookeeper_id = count.index
    sshUser      = var.linux_user
  }

  subnet_id                   = local.subnet_ids[var.deployment_type][count.index % length(local.subnet_ids[var.deployment_type])]
  vpc_security_group_ids      = local.security_groups[var.deployment_type]
  associate_public_ip_address = var.deployment_type == "public" ? true : false

  lifecycle {
    create_before_destroy = true
  }
}

# Instances EC2 Controller
resource "aws_instance" "controllers" {
  count         = var.controller_count
  ami           = data.aws_ami.selected.id
  instance_type = var.controller_instance_type
  key_name      = var.key_name

  root_block_device {
    volume_size = 50
    encrypted   = true
  }

  tags = {
    Name          = "${var.dns_suffix}-controller-${count.index}"
    description   = "Controller nodes - Managed by Terraform"
    role          = "controller"
    controller_id = count.index
    sshUser       = var.linux_user
  }

  subnet_id                   = local.subnet_ids[var.deployment_type][count.index % length(local.subnet_ids[var.deployment_type])]
  vpc_security_group_ids      = local.security_groups[var.deployment_type]
  associate_public_ip_address = var.deployment_type == "public" ? true : false

  lifecycle {
    create_before_destroy = true
  }
}

# Instances EC2 Broker
resource "aws_instance" "brokers" {
  count         = var.broker_count
  ami           = data.aws_ami.selected.id
  instance_type = var.broker_instance_type
  key_name      = var.key_name

  root_block_device {
    volume_size = 50
    encrypted   = true
  }

  tags = {
    Name        = "${var.dns_suffix}-broker-${count.index}"
    description = "Broker nodes - Managed by Terraform"
    role        = "broker"
    broker_id   = count.index
    sshUser     = var.linux_user
  }

  subnet_id                   = local.subnet_ids[var.deployment_type][count.index % length(local.subnet_ids[var.deployment_type])]
  vpc_security_group_ids      = local.security_groups[var.deployment_type]
  associate_public_ip_address = var.deployment_type == "public" ? true : false

  lifecycle {
    create_before_destroy = true
  }
}

# Instances EC2 Connect
resource "aws_instance" "connect" {
  count         = var.connect_count
  ami           = data.aws_ami.selected.id
  instance_type = var.connect_instance_type
  key_name      = var.key_name

  root_block_device {
    volume_size = 50
    encrypted   = true
  }

  tags = {
    Name        = "${var.dns_suffix}-connect-${count.index}"
    description = "Connect nodes - Managed by Terraform"
    role        = "connect"
    connect_id  = count.index
    sshUser     = var.linux_user
  }

  subnet_id                   = local.subnet_ids[var.deployment_type][count.index % length(local.subnet_ids[var.deployment_type])]
  vpc_security_group_ids      = local.security_groups[var.deployment_type]
  associate_public_ip_address = var.deployment_type == "public" ? true : false

  lifecycle {
    create_before_destroy = true
  }
}

# Instances EC2 Schema
resource "aws_instance" "schema" {
  count         = var.schema_count
  ami           = data.aws_ami.selected.id
  instance_type = var.schema_instance_type
  key_name      = var.key_name

  root_block_device {
    volume_size = 50
    encrypted   = true
  }

  tags = {
    Name        = "${var.dns_suffix}-schema-${count.index}"
    description = "Schema Registry nodes - Managed by Terraform"
    role        = "schema"
    schema_id   = count.index
    sshUser     = var.linux_user
  }

  subnet_id                   = local.subnet_ids[var.deployment_type][count.index % length(local.subnet_ids[var.deployment_type])]
  vpc_security_group_ids      = local.security_groups[var.deployment_type]
  associate_public_ip_address = var.deployment_type == "public" ? true : false

  lifecycle {
    create_before_destroy = true
  }
}

# Instances EC2 C3
resource "aws_instance" "c3" {
  count         = var.c3_count
  ami           = data.aws_ami.selected.id
  instance_type = var.c3_instance_type
  key_name      = var.key_name

  root_block_device {
    volume_size = 50
    encrypted   = true
  }

  tags = {
    Name        = "${var.dns_suffix}-c3-${count.index}"
    description = "C3 nodes - Managed by Terraform"
    role        = "c3"
    c3_id       = count.index
    sshUser     = var.linux_user
  }

  subnet_id                   = local.subnet_ids[var.deployment_type][count.index % length(local.subnet_ids[var.deployment_type])]
  vpc_security_group_ids      = local.security_groups[var.deployment_type]
  associate_public_ip_address = var.deployment_type == "public" ? true : false

  lifecycle {
    create_before_destroy = true
  }
}

# Instances EC2 KSQL
resource "aws_instance" "ksql" {
  count         = var.ksql_count
  ami           = data.aws_ami.selected.id
  instance_type = var.ksql_instance_type
  key_name      = var.key_name

  root_block_device {
    volume_size = 50
    encrypted   = true
  }

  tags = {
    Name        = "${var.dns_suffix}-ksql-${count.index}"
    description = "KSQL nodes - Managed by Terraform"
    role        = "ksql"
    ksql_id     = count.index
    sshUser     = var.linux_user
  }

  subnet_id                   = local.subnet_ids[var.deployment_type][count.index % length(local.subnet_ids[var.deployment_type])]
  vpc_security_group_ids      = local.security_groups[var.deployment_type]
  associate_public_ip_address = var.deployment_type == "public" ? true : false

  lifecycle {
    create_before_destroy = true
  }
}

# Instances EC2 REST
resource "aws_instance" "rest" {
  count         = var.rest_count
  ami           = data.aws_ami.selected.id
  instance_type = var.rest_instance_type
  key_name      = var.key_name

  root_block_device {
    volume_size = 50
    encrypted   = true
  }

  tags = {
    Name        = "${var.dns_suffix}-rest-${count.index}"
    description = "REST Proxy nodes - Managed by Terraform"
    role        = "rest"
    rest_id     = count.index
    sshUser     = var.linux_user
  }

  subnet_id                   = local.subnet_ids[var.deployment_type][count.index % length(local.subnet_ids[var.deployment_type])]
  vpc_security_group_ids      = local.security_groups[var.deployment_type]
  associate_public_ip_address = var.deployment_type == "public" ? true : false

  lifecycle {
    create_before_destroy = true
  }
}
