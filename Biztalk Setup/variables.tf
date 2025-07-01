variable "biztalk_admin_username" {
  description = "Admin username for the BizTalk VMs"
  type        = string
}

variable "biztalk_admin_password" {
  description = "Admin password for the BizTalk VMs"
  type        = string
  sensitive   = true
}

variable "biztalk_location" {
  description = "Azure region for BizTalk deployment"
  type        = string
}