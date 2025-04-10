provider "panos" {
  hostname = var.paloalto_hostname
  username = var.paloalto_username
  password = var.paloalto_password
}

resource "panos_device" "management_config" {
  hostname = var.firewall_hostname
  mgmt_ip_address = var.management_ip
  mgmt_netmask = var.management_netmask
  mgmt_default_gateway = var.management_gateway
}