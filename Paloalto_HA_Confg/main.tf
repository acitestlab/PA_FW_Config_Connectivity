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

resource "panos_panorama_virtual_router" "example" {
  name = "example-vr"
  template = panos_panorama_template.example.name
}

resource "panos_panorama_interface" "dmz" {
  name = "ethernet1/1"
  ip_address = var.dmz_ip
  template = panos_panorama_template.example.name
}

resource "panos_panorama_interface" "internal" {
  name = "ethernet1/2"
  ip_address = var.internal_ip
  template = panos_panorama_template.example.name
}

resource "panos_panorama_interface" "external" {
  name = "ethernet1/3"
  ip_address = var.external_ip
  template = panos_panorama_template.example.name
}

resource "panos_panorama_zone" "internal_zone" {
  name = "internal-zone"
  template = panos_panorama_template.example.name
  interfaces = [panos_panorama_interface.internal.name]
}

resource "panos_panorama_zone" "external_zone" {
  name = "external-zone"
  template = panos_panorama_template.example.name
  interfaces = [panos_panorama_interface.external.name]
}

resource "panos_panorama_ospf" "example" {
  virtual_router = panos_panorama_virtual_router.example.name
  template = panos_panorama_template.example.name
  area = "0.0.0.0"
  interface = panos_panorama_interface.internal.name
}

resource "panos_panorama_static_route" "to_wan" {
  name = "to-wan"
  virtual_router = panos_panorama_virtual_router.example.name
  template = panos_panorama_template.example.name
  destination = "0.0.0.0/0"
  nexthop_type = "ip-address"
  nexthop = var.wan_ip
}