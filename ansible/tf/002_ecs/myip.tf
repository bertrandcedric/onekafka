data "http" "my_ip" {
  url = "https://api.ipify.org"
}

locals {
  my_ip      = chomp(data.http.my_ip.response_body)
  my_ip_cidr = "${local.my_ip}/32"
}