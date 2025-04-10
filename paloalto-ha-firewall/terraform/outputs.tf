output "firewall_ip" {
  value = aws_instance.paloalto_firewall.public_ip
}

output "firewall_id" {
  value = aws_instance.paloalto_firewall.id
}

output "ha_status" {
  value = aws_instance.paloalto_firewall.ha_status
}