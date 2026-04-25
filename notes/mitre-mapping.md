# MITRE ATT&CK Mapping

| Technique | ID | Query | Observed Behaviour |
|-----------|-----|-------|--------------------|
| Ingress Tool Transfer | T1105 | — | PowerShell downloads client.py from C2 HTTP server |
| Windows Command Shell | T1059.003 | 02_process_tree | cmd.exe used to launch pythonw.exe with payload |
| Masquerading | T1036 | 04_filesystem | Payload named w_update.py to blend with system files |
| Non-Application Layer Protocol | T1095 | 01_network_connections | Raw TCP socket to C2, no application-layer protocol |
| Boot/Logon Autostart: Startup Folder | T1547.001 | 03_persistence | win_log.vbs written to Startup Folder for persistence |
