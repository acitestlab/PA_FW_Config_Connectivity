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

resource "panos_panorama_nat_rule" "source_nat" {
  name = "source-nat"
  device_group = panos_panorama_device_group.example.name
  source_zones = ["internal-zone"]
  destination_zone = "external-zone"
  source_addresses = ["any"]
  destination_addresses = ["any"]
  service = "any"
  to_interface = "ethernet1/3"
  source_translation {
    dynamic_ip_and_port {
      translated_addresses = [var.external_ip]
    }
  }
}

resource "panos_panorama_nat_rule" "destination_nat" {
  name = "destination-nat"
  device_group = panos_panorama_device_group.example.name
  source_zones = ["external-zone"]
  destination_zone = "internal-zone"
  source_addresses = ["any"]
  destination_addresses = [var.public_ip]
  service = "any"
  destination_translation {
    translated_address = var.internal_ip
  }
}