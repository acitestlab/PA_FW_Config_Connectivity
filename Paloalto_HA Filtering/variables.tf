variable "hostname" {
  description = "The hostname or IP address of the Palo Alto firewall"
  type        = string
}

variable "username" {
  description = "The username for authentication"
  type        = string
}

variable "password" {
  description = "The password for authentication"
  type        = string
  sensitive   = true
}

variable "vsys" {
  description = "The virtual system (vsys) to query"
  type        = string
  default     = "vsys1"
}

variable "rule_name" {
  description = "The name of the security policy rule to filter"
  type        = string
  default     = ""
}