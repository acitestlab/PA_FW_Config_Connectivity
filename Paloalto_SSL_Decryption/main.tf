provider "panos" {
  hostname = var.hostname
  username = var.username
  password = var.password
}

resource "panos_panorama_template" "example" {
  name = "example-template"
}

resource "panos_panorama_device_group" "example" {
  name = "example-device-group"
}

resource "panos_panorama_ssl_decrypt" "outbound_decrypt" {
  name = "outbound-decrypt"
  device_group = panos_panorama_device_group.example.name
  source_zones = ["internal-zone"]
  destination_zones = ["external-zone"]
  source_addresses = ["any"]
  destination_addresses = ["any"]
  services = ["any"]
  action = "decrypt"
  type = "ssl-forward-proxy"
}

resource "panos_panorama_ssl_decrypt" "inbound_decrypt" {
  name = "inbound-decrypt"
  device_group = panos_panorama_device_group.example.name
  source_zones = ["external-zone"]
  destination_zones = ["internal-zone"]
  source_addresses = ["any"]
  destination_addresses = ["any"]
  services = ["any"]
  action = "decrypt"
  type = "ssl-inbound-inspection"
  certificate = var.ssl_certificate
  private_key = var.ssl_private_key
}