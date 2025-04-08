provider "panos" {
  hostname = var.hostname
  username = var.username
  password = var.password
}

data "panos_security_policy" "filtered_policies" {
  vsys = var.vsys
  rule_name = var.rule_name
}

output "filtered_policies" {
  value = data.panos_security_policy.filtered_policies
}