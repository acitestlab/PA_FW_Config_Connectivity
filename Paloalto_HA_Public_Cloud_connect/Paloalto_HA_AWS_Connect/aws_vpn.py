import boto3

# AWS Configuration
AWS_REGION = "your-region"
AWS_VPC_ID = "your-vpc-id"
AWS_CUSTOMER_GATEWAY_IP = "your-firewall-ip"
AWS_VPN_CONNECTION_NAME = "your-vpn-connection-name"

def configure_aws_vpn():
    ec2 = boto3.client('ec2', region_name=AWS_REGION)

    # Create Customer Gateway
    customer_gateway = ec2.create_customer_gateway(
        Type='ipsec.1',
        PublicIp=AWS_CUSTOMER_GATEWAY_IP,
        BgpAsn=65000
    )
    customer_gateway_id = customer_gateway['CustomerGateway']['CustomerGatewayId']

    # Create Virtual Private Gateway
    virtual_private_gateway = ec2.create_vpn_gateway(
        Type='ipsec.1'
    )
    virtual_private_gateway_id = virtual_private_gateway['VpnGateway']['VpnGatewayId']

    # Attach Virtual Private Gateway to VPC
    ec2.attach_vpn_gateway(
        VpnGatewayId=virtual_private_gateway_id,
        VpcId=AWS_VPC_ID
    )

    # Create VPN Connection
    vpn_connection = ec2.create_vpn_connection(
        CustomerGatewayId=customer_gateway_id,
        Type='ipsec.1',
        VpnGatewayId=virtual_private_gateway_id,
        Options={
            'StaticRoutesOnly': True
        }
    )
    vpn_connection_id = vpn_connection['VpnConnection']['VpnConnectionId']

    # Create Static Routes
    ec2.create_vpn_connection_route(
        DestinationCidrBlock='10.0.0.0/16',
        VpnConnectionId=vpn_connection_id
    )

if __name__ == "__main__":
    configure_aws_vpn()