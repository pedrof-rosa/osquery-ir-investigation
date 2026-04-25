# Attack Simulation — Educational Purpose Only

These scripts were developed for an academic proof-of-concept investigating 
OsQuery's effectiveness in detecting C2 backdoor activity on a Windows 10 endpoint.

All tests were performed in an isolated lab environment (local VM network).
The C2 IP address and port have been removed from the public version of client.py.

## How the attack works

1. A `.bat` dropper (social engineering vector) downloads `client.py` from the C2 
   server via PowerShell and executes it silently from `%TEMP%`.
2. `client.py` establishes persistence by writing a VBS wrapper (`win_log.vbs`) 
   to the Windows Startup Folder.
3. The client beacons to the C2 server every 10 seconds until a connection 
   is established, then enters a command execution loop.
4. `server.py` runs on the attacker machine, accepts the reverse shell, 
   and sends commands interactively.

## MITRE ATT&CK coverage

| Technique | ID |
|-----------|----|
| Ingress Tool Transfer | T1105 |
| Boot/Logon Autostart: Startup Folder | T1547.001 |
| Masquerading | T1036 |
| Non-Application Layer Protocol | T1095 |
| Windows Command Shell | T1059.003 |
