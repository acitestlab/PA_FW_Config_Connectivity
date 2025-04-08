import os
import subprocess

# Define variables
variables = {
    "hostname": "your-firewall-hostname",
    "username": "your-username",
    "password": "your-password",
    "dmz_ip": "192.168.1.1",
    "internal_ip": "192.168.2.1",
    "external_ip": "192.168.3.1",
    "wan_ip": "192.168.4.1"
}

# Write variables to a Terraform variable file
with open('terraform.tfvars', 'w') as f:
    for key, value in variables.items():
        f.write(f'{key} = "{value}"\n')

# Initialize Terraform
subprocess.run(["terraform", "init"], check=True)

# Apply Terraform configuration
subprocess.run(["terraform", "apply", "-auto-approve"], check=True)