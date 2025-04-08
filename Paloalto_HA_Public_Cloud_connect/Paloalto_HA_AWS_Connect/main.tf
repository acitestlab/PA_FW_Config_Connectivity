provider "aws" {
  region = var.aws_region
}

resource "aws_vpn_gateway" "example" {
  vpc_id = var.vpc_id
}

resource "aws_customer_gateway" "example" {
  bgp_asn    = var.bgp_asn
  ip_address = var.firewall_ip
  type       = "ipsec.1"
}

resource "aws_vpn_connection" "example" {
  customer_gateway_id = aws_customer_gateway.example.id
  vpn_gateway_id      = aws_vpn_gateway.example.id
  type                = "ipsec.1"

  static_routes_only = true

  tags = {
    Name = "example-vpn-connection"
  }
}

resource "aws_vpn_connection_route" "example" {
  destination_cidr_block = var.destination_cidr_block
  vpn_connection_id      = aws_vpn_connection.example.id
}