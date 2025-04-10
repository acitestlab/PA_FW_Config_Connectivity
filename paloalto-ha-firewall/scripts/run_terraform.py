import json
import subprocess

def load_variables(file_path):
    with open(file_path, 'r') as f:
        return json.load(f)

def run_terraform(command):
    subprocess.run(command, check=True)

if __name__ == "__main__":
    variables_file = 'scripts/config/variables.json'
    variables = load_variables(variables_file)

    # Initialize Terraform
    run_terraform(['terraform', 'init'])

    # Apply Terraform configuration with variables
    run_terraform(['terraform', 'apply', '-var', f'var1={variables["var1"]}', '-var', f'var2={variables["var2"]}', '-auto-approve'])