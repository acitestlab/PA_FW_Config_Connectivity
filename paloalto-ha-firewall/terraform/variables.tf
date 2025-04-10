variable "firewall_name" {
  description = "The name of the Palo Alto firewall."
  type        = string
}

variable "management_ip" {
  description = "The management IP address of the firewall."
  type        = string
}

variable "ha_peer_ip" {
  description = "The HA peer IP address for the firewall."
  type        = string
}

variable "zone_name" {
  description = "The name of the security zone."
  type        = string
}

variable "vlan_id" {
  description = "The VLAN ID for the firewall interfaces."
  type        = number
}

variable "admin_username" {
  description = "The admin username for the firewall."
  type        = string
}

variable "admin_password" {
  description = "The admin password for the firewall."
  type        = string
  sensitive   = true
}