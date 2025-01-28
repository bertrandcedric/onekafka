variable "region" {
  description = ""
  type        = string
  nullable    = false
}

variable "prefix" {
  description = ""
  type        = string
  nullable    = false
}

variable "vpc_id" {
  description = ""
  type        = string
  nullable    = false
}

variable "public_subnet_id" {
  description = ""
  type        = list(string)
  nullable    = false
}

variable "private_subnet_id" {
  description = ""
  type        = list(string)
  nullable    = false
}

variable "hosted_zone_id" {
  description = ""
  type        = string
  nullable    = false
}

variable "key_name" {
  description = ""
  type        = string
  nullable    = false
}

variable "internal_security_group_name" {
  description = ""
  type        = string
  nullable    = false
}

variable "external_security_group_name" {
  description = ""
  type        = string
  nullable    = false
}

variable "instance_type" {
  description = ""
  type        = string
  nullable    = false
  default     = "t2.micro"
}

variable "tags" {
  description = ""
  type        = map(string)
  nullable    = false
}

variable "ami_keyword" {
  type        = string
  description = "AMI Keyword"
  validation {
    condition     = can(regex("^(rhel-[89]|ubuntu-[0-9]{2}.[0-9]{2}|amazon-linux-2|amazon-linux-2023)$", var.ami_keyword))
    error_message = "Invalid AMI keyword. Supported values: rhel-8, rhel-9, ubuntu-22.04, ubuntu-20.04, ubuntu-24.04, amazon-linux-2, amazon-linux-2023"
  }
  nullable = false
}

# CUSTOM CP_ANSIBLE

variable "deployment_type" {
  description = "The type of deployment (e.g., public, private)."
  type        = string
  validation {
    condition     = contains(["public", "private"], var.deployment_type)
    error_message = "The deployment_type must be either 'public' or 'private'."
  }
  nullable = false
}

variable "dns_suffix" {
  description = "Suffix for DNS entries in Route 53. No spaces allowed."
  type        = string
  nullable    = false
}

variable "zk_count" {
  description = "Number of Zookeeper instances to create."
  type        = number
  nullable    = false
}

variable "controller_count" {
  description = "Number of controller instances to create."
  type        = number
  nullable    = false
}

variable "broker_count" {
  description = "Number of broker instances to create."
  type        = number
  nullable    = false
}

variable "connect_count" {
  description = "Number of Connect instances to create."
  type        = number
  nullable    = false
}

variable "schema_count" {
  description = "Number of Schema Registry instances to create."
  type        = number
  nullable    = false
}

variable "rest_count" {
  description = "Number of REST Proxy instances to create."
  type        = number
  nullable    = false
}

variable "c3_count" {
  description = "Number of C3 instances to create."
  type        = number
  nullable    = false
}

variable "ksql_count" {
  description = "Number of KSQL instances to create."
  type        = number
  nullable    = false
}

variable "zk_instance_type" {
  description = "The instance type for Zookeeper instances. Default is t3a.large."
  nullable    = false
}

variable "controller_instance_type" {
  description = "The instance type for controller instances. Default is t3a.large."
  nullable    = false
}

variable "broker_instance_type" {
  description = "The instance type for broker instances. Default is t3a.large."
  nullable    = false
}

variable "schema_instance_type" {
  description = "The instance type for schema registry instances. Default is t3a.large."
  nullable    = false
}

variable "connect_instance_type" {
  description = "The instance type for Connect instances. Default is t3a.large."
  nullable    = false
}

variable "rest_instance_type" {
  description = "The instance type for REST Proxy instances. Default is t3a.large."
  nullable    = false
}

variable "c3_instance_type" {
  description = "The instance type for C3 instances. Default is t3a.large."
  nullable    = false
}

variable "ksql_instance_type" {
  description = "The instance type for KSQL instances. Default is t3a.large."
  nullable    = false
}

variable "linux_user" {
  description = "The default Linux user for SSH access (e.g., 'ubuntu' for Ubuntu AMIs, 'ec2-user' for Amazon Linux)."
  default     = "ubuntu"
  nullable    = false
}

variable "hosts_templatefile" {
  default  = "cp_hosts.tftpl"
  nullable = false
}

variable "json_templatefile" {
  default  = "cp_json.tftpl"
  nullable = false
}

variable "hosts_jumphost_templatefile" {
  default  = "cp_hosts_jumphost.tftpl"
  nullable = false
}

variable "inventory_file" {
  default  = "ansible/hosts.yml"
  nullable = false
}

variable "json_file" {
  default  = "ansible/hosts.json"
  nullable = false
}

variable "inventory_jumphost_file" {
  default  = "ansible/hosts_jumphost.yml"
  nullable = false
}
