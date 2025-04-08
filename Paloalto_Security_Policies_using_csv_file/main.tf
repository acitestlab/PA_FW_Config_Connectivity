# main.tf
provider "panos" {
  hostname = var.hostname
  username = var.username
  password = var.password
}

resource "panos_security_policy" "example" {
  for_each = { for policy in csvdecode(file("${path.module}/palo_alto_config.csv")) : policy.policy_name => policy }

  name              = each.value.policy_name
  source_zones      = [each.value.source_zone]
  destination_zones = [each.value.destination_zone]
  source_addresses  = [each.value.source_address]
  destination_addresses = [each.value.destination_address]
  applications      = [each.value.application]
  services          = [each.value.service]
  action            = each.value.action
}