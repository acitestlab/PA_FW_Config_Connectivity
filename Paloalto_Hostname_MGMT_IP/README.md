Here is the Terraform script and Python script to configure the hostname and static management IP of a new Palo Alto firewall. The files are provided separately in the directory structure.

/workspaces/PA_FW_Config_Connectivity/Paloalto_Hostname_MGMT_IP/
├── main.tf
├── variables.tf
├── terraform.tfvars
├── deploy.py

Execution Steps
    1.  Save the Terraform files (main.tf, variables.tf, terraform.tfvars) and the Python script (deploy.py) in the specified paths.
    2.  Install Terraform and Python dependencies:

            sudo apt-get install terraform
            pip install subprocess

    3.  Run the Python script to execute the Terraform script

            python deploy.py

This will configure the hostname and static management IP of the Palo Alto firewall. Adjust the variables in terraform.tfvars as needed for your environment.  
