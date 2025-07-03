import subprocess
import socket

# Set this to your BizTalkDC public IP from Terraform output or Azure Portal
public_ip = "172.174.76.107"  # <-- Replace with your actual public IP

# Private IPs for traceroute demonstration
private_ips = [
    "10.0.1.4",  # BizTalkDC
    "10.0.1.5",  # BizTalkSQL
    "10.0.1.6"   # BizTalkApp
]

def test_ping(target_ip):
    print(f"Pinging {target_ip}...")
    try:
        result = subprocess.run(
            ["ping", "-c", "2", "-W", "2", target_ip],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        if result.returncode == 0:
            print(f"Ping to {target_ip} successful.")
        else:
            print(f"Ping to {target_ip} failed.")
    except Exception as e:
        print(f"Error pinging {target_ip}: {e}")

def test_rdp(ip):
    print(f"Checking RDP port on {ip}...")
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.settimeout(3)
    result = sock.connect_ex((ip, 3389))
    if result == 0:
        print(f"RDP port open on {ip}")
    else:
        print(f"RDP port closed on {ip}")
    sock.close()

def traceroute_ip(ip):
    print(f"Traceroute to {ip}...")
    try:
        result = subprocess.run(
            ["traceroute", ip],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        print(result.stdout)
    except Exception as e:
        print(f"Error running traceroute to {ip}: {e}")

if __name__ == "__main__":
    # Test public IP connectivity
    test_ping(public_ip)
    test_rdp(public_ip)

    # Traceroute to private IPs (will not reach from Codespaces, but shows routing path)
    for ip in private_ips:
        traceroute_ip(ip)