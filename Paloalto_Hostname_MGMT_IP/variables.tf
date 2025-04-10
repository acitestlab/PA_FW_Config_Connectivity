variable "paloalto_hostname" {
  description = "The IP or hostname of the Palo Alto firewall"
  type        = string
}

variable "paloalto_username" {
  description = "The username for the Palo Alto firewall"
  type        = string
}

variable "paloalto_password" {
  description = "The password for the Palo Alto firewall"
  type        = string
  sensitive   = true
}

variable "firewall_hostname" {
  description = "The desired hostname for the Palo Alto firewall"
  type        = string
}

variable "management_ip" {
  description = "The static management IP address for the Palo Alto firewall"
  type        = string
}

variable "management_netmask" {
  description = "The netmask for the management IP address"
  type        = string
}

variable "management_gateway" {
  description = "The default gateway for the management IP address"
  type        = string
}