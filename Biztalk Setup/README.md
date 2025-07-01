# BizTalk Azure Deployment

## Structure

- `main.tf`, `variables.tf`, `terraform.tfvars`: Terraform infrastructure as code
- `deploy_infra.py`: Deploys infrastructure using Terraform
- `join_domain.py`: Joins SQL and BizTalk VMs to the domain
- `test_connectivity.py`: Tests network connectivity between VMs

## Usage

1. Edit `terraform.tfvars` with your credentials and region.
2. Run `python3 deploy_infra.py` to deploy infrastructure.
3. After DC is promoted, update `join_domain.py` with domain admin credentials and run it.
4. Run `python3 test_connectivity.py` to validate connectivity.

## Requirements

- Terraform
- Python 3.x
- Azure CLI logged in
- Python packages: `pythonping`, `azure-identity`, `azure-mgmt-compute`