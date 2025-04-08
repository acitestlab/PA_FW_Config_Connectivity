from azure.identity import DefaultAzureCredential #ignore
from azure.mgmt.network import NetworkManagementClient #ignore

# Azure Configuration
AZURE_SUBSCRIPTION_ID = "your-subscription-id"
AZURE_RESOURCE_GROUP = "your-resource-group"
AZURE_LOCATION = "your-location"
AZURE_VNET_NAME = "your-vnet-name"
AZURE_VNET_GATEWAY_NAME = "your-vnet-gateway-name"
AZURE_LOCAL_NETWORK_GATEWAY_NAME = "your-local-network-gateway-name"
AZURE_CONNECTION_NAME = "your-connection-name"

def configure_azure_vpn():
    credential = DefaultAzureCredential()
    network_client = NetworkManagementClient(credential, AZURE_SUBSCRIPTION_ID)

    # Create Virtual Network Gateway
    vnet_gateway_params = {
        "location": AZURE_LOCATION,
        "properties": {
            "ipConfigurations": [
                {
                    "name": "vnetGatewayConfig",
                    "properties": {
                        "privateIPAllocationMethod": "Dynamic",
                        "subnet": {
                            "id": f"/subscriptions/{AZURE_SUBSCRIPTION_ID}/resourceGroups/{AZURE_RESOURCE_GROUP}/providers/Microsoft.Network/virtualNetworks/{AZURE_VNET_NAME}/subnets/GatewaySubnet"
                        }
                    }
                }
            ],
            "gatewayType": "Vpn",
            "vpnType": "RouteBased",
            "enableBgp": False,
            "sku": {
                "name": "VpnGw1",
                "tier": "VpnGw1"
            }
        }
    }
    network_client.virtual_network_gateways.begin_create_or_update(AZURE_RESOURCE_GROUP, AZURE_VNET_GATEWAY_NAME, vnet_gateway_params).result()

    # Create Local Network Gateway
    local_network_gateway_params = {
        "location": AZURE_LOCATION,
        "properties": {
            "gatewayIpAddress": "your-firewall-ip",
            "localNetworkAddressSpace": {
                "addressPrefixes": ["10.0.0.0/16"]
            }
        }
    }
    network_client.local_network_gateways.begin_create_or_update(AZURE_RESOURCE_GROUP, AZURE_LOCAL_NETWORK_GATEWAY_NAME, local_network_gateway_params).result()

    # Create Connection
    connection_params = {
        "location": AZURE_LOCATION,
        "properties": {
            "connectionType": "IPsec",
            "virtualNetworkGateway1": {
                "id": f"/subscriptions/{AZURE_SUBSCRIPTION_ID}/resourceGroups/{AZURE_RESOURCE_GROUP}/providers/Microsoft.Network/virtualNetworkGateways/{AZURE_VNET_GATEWAY_NAME}"
            },
            "localNetworkGateway2": {
                "id": f"/subscriptions/{AZURE_SUBSCRIPTION_ID}/resourceGroups/{AZURE_RESOURCE_GROUP}/providers/Microsoft.Network/localNetworkGateways/{AZURE_LOCAL_NETWORK_GATEWAY_NAME}"
            },
            "sharedKey": "your-pre-shared-key"
        }
    }
    network_client.virtual_network_gateway_connections.begin_create_or_update(AZURE_RESOURCE_GROUP, AZURE_CONNECTION_NAME, connection_params).result()

if __name__ == "__main__":
    configure_azure_vpn()
