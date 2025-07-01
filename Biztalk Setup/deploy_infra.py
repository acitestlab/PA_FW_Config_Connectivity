import subprocess
import sys
import os

def run_cmd(cmd, cwd=None):
    print(f"Running: {' '.join(cmd)}")
    result = subprocess.run(cmd, cwd=cwd, capture_output=True, text=True)
    print(result.stdout)
    if result.returncode != 0:
        print(result.stderr)
        sys.exit(result.returncode)

def main():
    tf_dir = os.path.abspath(os.path.dirname(__file__))
    var_file = os.path.join(tf_dir, "terraform.tfvars")

    # Terraform init
    run_cmd(["terraform", "init"], cwd=tf_dir)

    # Terraform plan
    run_cmd(["terraform", "plan", f"-var-file={var_file}"], cwd=tf_dir)

    # Terraform apply
    run_cmd(["terraform", "apply", "-auto-approve", f"-var-file={var_file}"], cwd=tf_dir)

if __name__ == "__main__":
    main()