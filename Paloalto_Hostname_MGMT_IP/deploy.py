import os
import subprocess

def run_terraform():
    try:
        # Initialize Terraform
        subprocess.run(["terraform", "init"], check=True)
        
        # Apply Terraform configuration
        subprocess.run(["terraform", "apply", "-auto-approve"], check=True)
        
        print("Terraform script executed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error occurred while running Terraform: {e}")

if __name__ == "__main__":
    # Ensure Terraform is executed in the correct directory
    os.chdir(os.path.dirname(__file__))
    run_terraform()