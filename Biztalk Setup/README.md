# BizTalk Azure Deployment

This project provides Terraform and Python scripts to deploy a BizTalk Server environment on Azure, including a Domain Controller, SQL Server, and BizTalk Server, all within a single subnet. It also includes scripts for connectivity testing and resource cleanup.

---

## **Project Structure**

```
Biztalk Setup/
├── main.tf                  # Main Terraform configuration
├── variables.tf             # Terraform variable definitions
├── terraform.tfvars         # Variable values (user secrets, region, etc.)
├── deploy_infra.py          # Python script to deploy infrastructure
├── destroy_infra.sh         # Bash script to destroy all resources
├── deallocate_vms.sh        # Bash script to deallocate (stop) all VMs
├── join_domain.py           # Python script to join VMs to the domain (optional)
├── test_connectivity.py     # Python script to test public/private connectivity
```

---

## **Deployment Steps**

### 1. **Configure Variables**

Edit `terraform.tfvars` with your Azure credentials and region:
```hcl
biztalk_admin_username = "youradmin"
biztalk_admin_password = "YourSecurePassword123!"
biztalk_location       = "East US"
biztalk_subscription_id = "your-azure-subscription-id"
```

### 2. **Deploy Infrastructure**

From the `Biztalk Setup` directory, run:
```bash
python3 deploy_infra.py
```
This will initialize Terraform, plan, and apply the deployment.

### 3. **Get the Public IP**

After deployment, Terraform will output the public IP for BizTalkDC.  
Use this IP for connectivity tests and RDP.

### 4. **Test Connectivity**

Edit `test_connectivity.py` and set `public_ip` to the value output by Terraform.  
Then run:
```bash
python3 test_connectivity.py
```
This will:
- Ping the public IP
- Check RDP port on the public IP
- Traceroute to the private IPs (for demonstration; will not reach from outside Azure)

### 5. **Join Domain (Optional)**

If you want to join SQL and BizTalk VMs to the domain, update `join_domain.py` with your domain admin credentials and run:
```bash
python3 join_domain.py
```

### 6. **Deallocate or Destroy Resources**

- To **deallocate (stop) VMs** (saves compute cost, keeps storage):
  ```bash
  bash deallocate_vms.sh
  ```
- To **destroy all resources** (removes all Azure charges for these resources):
  ```bash
  bash destroy_infra.sh
  ```
cd /workspaces/PA_FW_Config_Connectivity
bash "Biztalk Setup/destroy_infra.sh"
---

## **Security Notes**

- The public IP and open RDP/ICMP rules are for testing/demo only.  
  For production, restrict NSG rules to your own IP and remove public IPs.
- Never commit real passwords or secrets to version control.

---

## **Requirements**

- [Terraform](https://www.terraform.io/)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- Python 3.x
- Python packages: `azure-identity`, `azure-mgmt-compute` (for domain join), `pythonping` (optional)
- Bash (for shell scripts)

---

## **Troubleshooting**

- If you get quota or SKU errors for public IPs, change `sku = "Basic"` to `sku = "Standard"` in `main.tf`.
- Codespaces or your laptop cannot reach Azure private IPs directly; use the public IP for external tests.
- For more advanced scenarios, consider using Azure Bastion or a jumpbox.

---

## **License**

MIT License

---