import pandevice  # type: ignore
from pandevice.firewall import Firewall # type: ignore
from pandevice.network import EthernetInterface, Zone, VirtualRouter, StaticRoute, Ospf # type: ignore

# Define firewall connection details
hostname = "your-firewall-hostname"
username = "your-username"
password = "your-password"

# Connect to the firewall
fw = Firewall(hostname, username, password)

# Verify interfaces
interfaces = EthernetInterface.refreshall(fw)
for interface in interfaces:
    print(f"Interface {interface.name}: {interface.ip}")

# Verify zones
zones = Zone.refreshall(fw)
for zone in zones:
    print(f"Zone {zone.name}: {zone.interface}")

# Verify virtual routers
vrs = VirtualRouter.refreshall(fw)
for vr in vrs:
    print(f"Virtual Router {vr.name}")

# Verify OSPF configuration
ospfs = Ospf.refreshall(fw)
for ospf in ospfs:
    print(f"OSPF Area {ospf.area}")

# Verify static routes
static_routes = StaticRoute.refreshall(fw)
for route in static_routes:
    print(f"Static Route {route.name}: {route.destination} via {route.nexthop}")