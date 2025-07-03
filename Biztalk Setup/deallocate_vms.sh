#!/bin/bash
# filepath: Biztalk Setup/deallocate_vms.sh

RESOURCE_GROUP="BizTalkRG"
VM_NAMES=("BizTalkDC" "BizTalkSQL" "BizTalkApp")

for VM in "${VM_NAMES[@]}"; do
    echo "Deallocating $VM..."
    az vm deallocate --resource-group "$RESOURCE_GROUP" --name "$VM"
done