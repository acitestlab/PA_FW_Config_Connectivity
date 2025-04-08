import os
import subprocess

# Define variables
variables = {
    "hostname": "your-firewall-hostname",
    "username": "your-username",
    "password": "your-password"
}

# Write variables to a Terraform variable file
with open('terraform.tfvars', 'w') as f:
    for key, value in variables.items():
        f.write(f'{key} = "{value}"\n')

# Initialize Terraform
subprocess.run(["terraform", "init"], check=True)

# Apply Terraform configuration
subprocess.run(["terraform", "apply", "-auto-approve"], check=True)