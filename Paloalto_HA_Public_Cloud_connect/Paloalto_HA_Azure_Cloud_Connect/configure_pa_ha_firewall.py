import requests
import json

# Load configuration from file
with open('config.json') as config_file:
    config = json.load(config_file)

PA_FIREWALL_IP = config['firewall_ip']
PA_API_KEY = config['api_key']
PEER_IP = config['peer_ip']
PRE_SHARED_KEY = config['pre_shared_key']
MONITOR_IP = config['monitor_ip']
HA_PEER_IP = config['ha_peer_ip']
HA_PRE_SHARED_KEY = config['ha_pre_shared_key']

def configure_pa_ha_firewall():
    # Define IKE Gateway
    ike_gateway_payload = {
        "entry": {
            "@name": "ike-gateway",
            "version": {
                "ikev2": {
                    "ike-crypto-profile": "default"
                }
            },
            "protocol": {
                "ikev2": {
                    "dpd": {
                        "enable": "yes",
                        "interval": "5",
                        "retry": "5"
                    }
                }
            },
            "peer-address": {
                "ip": PEER_IP
            },
            "local-address": {
                "interface": "ethernet1/1"
            },
            "authentication": {
                "pre-shared-key": {
                    "key": PRE_SHARED_KEY
                }
            }
        }
    }
    requests.post(f"https://{PA_FIREWALL_IP}/api/?type=config&action=set&xpath=/config/devices/entry[@name='localhost.localdomain']/network/ike/gateway&element={ike_gateway_payload}&key={PA_API_KEY}")

    # Define IPsec Tunnel
    ipsec_tunnel_payload = {
        "entry": {
            "@name": "ipsec-tunnel",
            "auto-key": {
                "ike-gateway": {
                    "entry": {
                        "@name": "ike-gateway"
                    }
                },
                "ipsec-crypto-profile": "default"
            },
            "tunnel-monitor": {
                "enable": "yes",
                "destination-ip": MONITOR_IP,
                "interval": "5",
                "retry": "3"
            },
            "tunnel-interface": "tunnel.1"
        }
    }
    requests.post(f"https://{PA_FIREWALL_IP}/api/?type=config&action=set&xpath=/config/devices/entry[@name='localhost.localdomain']/network/tunnel/ipsec&element={ipsec_tunnel_payload}&key={PA_API_KEY}")

    # Define Tunnel Interface
    tunnel_interface_payload = {
        "entry": {
            "@name": "tunnel.1",
            "ipv4": {
                "ip": {
                    "entry": {
                        "@name": "10.0.0.1/30"
                    }
                }
            }
        }
    }
    requests.post(f"https://{PA_FIREWALL_IP}/api/?type=config&action=set&xpath=/config/devices/entry[@name='localhost.localdomain']/network/interface/tunnel/units&element={tunnel_interface_payload}&key={PA_API_KEY}")

    # Define Static Routes
    static_route_payload = {
        "entry": {
            "@name": "route-to-azure",
            "destination": "10.1.0.0/16",
            "interface": "tunnel.1",
            "nexthop": {
                "ip-address": "10.0.0.2"
            }
        }
    }
    requests.post(f"https://{PA_FIREWALL_IP}/api/?type=config&action=set&xpath=/config/devices/entry[@name='localhost.localdomain']/network/virtual-router/entry[@name='default']/routing-table/ip/static-route&element={static_route_payload}&key={PA_API_KEY}")

if __name__ == "__main__":
    configure_pa_ha_firewall()