locals {
  ami_filters = {
    # Red Hat Enterprise Linux
    "rhel-9" = {
      owners       = ["309956199498"]
      name_pattern = "RHEL-9*"
    }
    "rhel-8" = {
      owners       = ["309956199498"]
      name_pattern = "RHEL-8*"
    }

    # Ubuntu
    "ubuntu-22.04" = {
      owners       = ["099720109477"]
      name_pattern = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    }
    "ubuntu-20.04" = {
      owners       = ["099720109477"]
      name_pattern = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
    }
    "ubuntu-24.04" = {
      owners       = ["099720109477"]
      name_pattern = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
    }

    # Amazon Linux
    "amazon-linux-2" = {
      owners       = ["137112412989"]
      name_pattern = "amzn2-ami-hvm-*-x86_64-gp2"
    }
    "amazon-linux-2023" = {
      owners       = ["137112412989"]
      name_pattern = "al2023-ami-*-x86_64"
    }

    # CentOS
    "centos-7" = {
      owners       = ["679593333241"]
      name_pattern = "CentOS Linux 7 x86_64 HVM EBS*"
    }
  }
}

data "aws_ami" "selected" {
  most_recent = true
  owners      = lookup(local.ami_filters, var.ami_keyword).owners

  filter {
    name   = "name"
    values = [lookup(local.ami_filters, var.ami_keyword).name_pattern]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}
