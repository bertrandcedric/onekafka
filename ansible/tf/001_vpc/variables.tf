variable "region" {
  description = ""
  type        = string
  nullable    = false
}

variable "vpc_name" {
  description = ""
  type        = string
  nullable    = false
}

variable "cidr" {
  description = ""
  type        = string
  nullable    = false
}

variable "azs" {
  description = ""
  type        = list(string)
  nullable    = false
}

variable "private_subnets" {
  description = ""
  type        = list(string)
  nullable    = false
}

variable "public_subnets" {
  description = ""
  type        = list(string)
  nullable    = false
}

variable "private_domain" {
  description = "Domain name for the private hosted zone"
  type        = string
  nullable    = false
}

variable "enable_private_dns" {
  description = "Whether to create private hosted zone"
  type        = bool
  nullable    = false
}

variable "tags" {
  description = ""
  type        = map(string)
  nullable    = false
}