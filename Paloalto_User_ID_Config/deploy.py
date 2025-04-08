import os
import subprocess

# Define variables
variables = {
    "hostname": "your-firewall-hostname",
    "username": "your-username",
    "password": "your-password",
    "user_id_agent_ip": "192.168.1.100",
    "user_id_agent_port": 5007,
    "user_id_agent_username": "your-agent-username",
    "user_id_agent_password": "your-agent-password"
}

# Write variables to a Terraform variable file
with open('terraform.tfvars', 'w') as f:
    for key, value in variables.items():
        f.write(f'{key} = "{value}"\n')

# Initialize Terraform
subprocess.run(["terraform", "init"], check=True)

# Apply Terraform configuration
subprocess.run(["terraform", "apply", "-auto-approve"], check=True)