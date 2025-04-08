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

resource "panos_panorama_user_id_agent" "example" {
  name = "example-user-id-agent"
  device_group = panos_panorama_device_group.example.name
  ip_address = var.user_id_agent_ip
  port = var.user_id_agent_port
  enable = true
}

resource "panos_panorama_user_id_agent_auth" "example" {
  name = "example-user-id-agent-auth"
  device_group = panos_panorama_device_group.example.name
  user_id_agent = panos_panorama_user_id_agent.example.name
  username = var.user_id_agent_username
  password = var.user_id_agent_password
}

resource "panos_panorama_user_id_include_list" "example" {
  name = "example-include-list"
  device_group = panos_panorama_device_group.example.name
  user_id_agent = panos_panorama_user_id_agent.example.name
  include_list = ["domain\\user1", "domain\\user2"]
}

resource "panos_panorama_user_id_exclude_list" "example" {
  name = "example-exclude-list"
  device_group = panos_panorama_device_group.example.name
  user_id_agent = panos_panorama_user_id_agent.example.name
  exclude_list = ["domain\\user3", "domain\\user4"]
}