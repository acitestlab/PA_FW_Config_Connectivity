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

resource "panos_panorama_security_policy" "allow_internal_to_external" {
  name = "allow-internal-to-external"
  device_group = panos_panorama_device_group.example.name
  rule {
    name = "allow-internal-to-external"
    source_zones = ["internal-zone"]
    destination_zones = ["external-zone"]
    source_addresses = ["any"]
    destination_addresses = ["any"]
    applications = ["any"]
    services = ["application-default"]
    action = "allow"
  }
}

resource "panos_panorama_security_policy" "deny_external_to_internal" {
  name = "deny-external-to-internal"
  device_group = panos_panorama_device_group.example.name
  rule {
    name = "deny-external-to-internal"
    source_zones = ["external-zone"]
    destination_zones = ["internal-zone"]
    source_addresses = ["any"]
    destination_addresses = ["any"]
    applications = ["any"]
    services = ["application-default"]
    action = "deny"
  }
}