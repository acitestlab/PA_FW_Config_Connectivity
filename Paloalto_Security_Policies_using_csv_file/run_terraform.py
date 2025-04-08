# run_terraform.py
import subprocess

def run_terraform():
    # Initialize Terraform
    subprocess.run(["terraform", "init"], check=True)
    
    # Apply Terraform configuration
    subprocess.run(["terraform", "apply", "-auto-approve"], check=True)

if __name__ == "__main__":
    run_terraform()