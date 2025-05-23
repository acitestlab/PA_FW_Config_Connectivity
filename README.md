# Palo Alto Firewall Automation Scripts

Automate your Palo Alto firewall configuration using **Terraform** and **Python**. This project provides IaC (Infrastructure as Code) scripts for:

- OS Upgrades
- Security Zones Configuration
- Security Policy Rules
- NAT Setup
- IPSec VPN to Cloud (AWS/Azure)
- HA Setup (Coming Soon)

---

## 🔧 Features

- 🔄 PAN-OS upgrade automation
- 🔐 Security and NAT rules management
- 🌐 IPSec VPN setup with AWS & Azure
- 🧱 Modular Terraform & Python codebase
- 🧪 Tested with PAN-OS 10.x and 11.x

---

## 🛠 Getting Started

### Requirements
- Terraform v1.3+
- Python 3.8+
- `pan-os-python` library
- PAN-OS API access or on-prem CLI access

### Terraform Setup
```bash
terraform init
terraform plan
terraform apply


