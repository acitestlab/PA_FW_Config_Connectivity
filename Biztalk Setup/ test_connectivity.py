from pythonping import ping
import socket

# Define VM private IPs
vms = {
    "BizTalkDC": "10.0.1.4",
    "BizTalkSQL": "10.0.1.5",
    "BizTalkApp": "10.0.1.6"
}

def test_ping(target_ip):
    print(f"Pinging {target_ip}...")
    response = ping(target_ip, count=2, timeout=2)
    if response.success():
        print(f"Ping to {target_ip} successful.")
    else:
        print(f"Ping to {target_ip} failed.")

def test_rdp(ip):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.settimeout(3)
    result = sock.connect_ex((ip, 3389))
    if result == 0:
        print(f"RDP port open on {ip}")
    else:
        print(f"RDP port closed on {ip}")
    sock.close()

if __name__ == "__main__":
    for name, ip in vms.items():
        test_ping(ip)
        test_rdp(ip)