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

resource "panos_panorama_anti_spyware_profile" "example" {
  name = "example-anti-spyware"
  device_group = panos_panorama_device_group.example.name
  rule {
    name = "default"
    action = "alert"
  }
}

resource "panos_panorama_antivirus_profile" "example" {
  name = "example-antivirus"
  device_group = panos_panorama_device_group.example.name
  rule {
    name = "default"
    action = "alert"
  }
}

resource "panos_panorama_url_filtering_profile" "example" {
  name = "example-url-filtering"
  device_group = panos_panorama_device_group.example.name
  rule {
    name = "default"
    action = "alert"
  }
}

resource "panos_panorama_security_profile_group" "example" {
  name = "example-security-profile-group"
  device_group = panos_panorama_device_group.example.name
  anti_spyware_profile = panos_panorama_anti_spyware_profile.example.name
  antivirus_profile = panos_panorama_antivirus_profile.example.name
  url_filtering_profile = panos_panorama_url_filtering_profile.example.name
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
    profile_setting {
      group = panos_panorama_security_profile_group.example.name
    }
  }
}