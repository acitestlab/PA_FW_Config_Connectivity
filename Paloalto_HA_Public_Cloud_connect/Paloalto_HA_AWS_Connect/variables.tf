variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "bgp_asn" {
  description = "The BGP ASN for the customer gateway"
  type        = number
}

variable "firewall_ip" {
  description = "The IP address of the Palo Alto firewall"
  type        = string
}

variable "destination_cidr_block" {
  description = "The destination CIDR block for the VPN connection route"
  type        = string
}