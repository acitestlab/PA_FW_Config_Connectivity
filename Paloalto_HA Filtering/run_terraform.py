import subprocess

def run_terraform():
    try:
        # Initialize Terraform
        subprocess.run(["terraform", "init"], check=True)

        # Apply Terraform configuration
        subprocess.run(["terraform", "apply", "-auto-approve"], check=True)

        # Output the filtered policies
        output = subprocess.run(["terraform", "output", "-json"], check=True, capture_output=True, text=True)
        print("Filtered Policies:")
        print(output.stdout)

    except subprocess.CalledProcessError as e:
        print(f"Error running Terraform: {e}")

if __name__ == "__main__":
    run_terraform()