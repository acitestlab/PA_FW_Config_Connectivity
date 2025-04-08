variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "firewall_ip" {
  description = "The IP address of the Palo Alto firewall"
  type        = string
}

variable "shared_key" {
  description = "The shared key for the VPN connection"
  type        = string
}