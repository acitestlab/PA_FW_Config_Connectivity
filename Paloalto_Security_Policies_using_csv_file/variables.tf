# variables.tf
variable "hostname" {
  description = "The hostname of the Palo Alto firewall"
  type        = string
}

variable "username" {
  description = "The username for the Palo Alto firewall"
  type        = string
}

variable "password" {
  description = "The password for the Palo Alto firewall"
  type        = string
  sensitive   = true
}