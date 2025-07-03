import subprocess

# Define VM private IPs
vms = {
    "BizTalkDC": "10.0.1.4",
    "BizTalkSQL": "10.0.1.5",
    "BizTalkApp": "10.0.1.6"
}

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