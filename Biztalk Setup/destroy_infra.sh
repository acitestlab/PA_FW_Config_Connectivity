#!/bin/bash
# filepath: Biztalk Setup/destroy_infra.sh

echo "This will destroy all BizTalk Azure resources managed by Terraform."
read -p "Are you sure you want to continue? (y/N): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Aborted."
    exit 1
fi

terraform -chdir="Biztalk Setup" destroy -auto-approve