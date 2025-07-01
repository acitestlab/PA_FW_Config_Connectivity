import os
from azure.identity import DefaultAzureCredential
from azure.mgmt.compute import ComputeManagementClient

subscription_id = os.environ.get("AZURE_SUBSCRIPTION_ID")
resource_group = "BizTalkRG"
domain = "biztalk.local"
domain_user = "biztalkadmin"
domain_pass = "YourDomainAdminPassword"

credential = DefaultAzureCredential()
compute_client = ComputeManagementClient(credential, subscription_id)

def run_command(vm_name):
    params = {
        "command_id": "RunPowerShellScript",
        "script": [
            f"$secpasswd = ConvertTo-SecureString '{domain_pass}' -AsPlainText -Force",
            f"$mycreds = New-Object System.Management.Automation.PSCredential ('{domain}\\{domain_user}', $secpasswd)",
            f"Add-Computer -DomainName {domain} -Credential $mycreds -Restart -Force"
        ]
    }
    poller = compute_client.virtual_machines.begin_run_command(resource_group, vm_name, params)
    result = poller.result()
    print(f"Domain join command sent to {vm_name}: {result.value}")

for vm in ["BizTalkSQL", "BizTalkApp"]:
    run_command(vm)