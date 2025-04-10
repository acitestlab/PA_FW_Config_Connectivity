provider "panos" {
  hostname = var.firewall_hostname
  username = var.firewall_username
  password = var.firewall_password
}

resource "panos_firewall" "ha_firewall" {
  name = var.firewall_name
  device_mode = var.device_mode
  ha {
    enable = true
    ha_type = var.ha_type
    ha_peer_ip = var.ha_peer_ip
  }
}

resource "panos_interface" "ha_interface" {
  name = var.interface_name
  virtual_router = var.virtual_router
  zone = var.zone
  ip_address = var.ip_address
  netmask = var.netmask
}

output "firewall_ip" {
  value = panos_interface.ha_interface.ip_address
}

output "firewall_id" {
  value = panos_firewall.ha_firewall.id
}