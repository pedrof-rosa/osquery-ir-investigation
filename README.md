# osquery-ir-investigation
Incident response lab using OsQuery to investigate a simulated C2 backdoor on a Windows 10 endpoint. Includes SQL queries, MITRE ATT&amp;CK mapping and notes on OsQuery limitations.
## Scenario
A .bat dropper delivers a Python reverse shell (w_update.py) to %TEMP%, 
establishing persistence via a VBS wrapper in the Startup Folder. 
The shell beacons to a C2 server (Fedora Linux) on port 4444.

## Investigation Goals
- Identify the process responsible for the suspicious outbound connection
- Reconstruct the process execution chain
- Locate the payload on the filesystem
- Detect persistence mechanisms

## Queries
| File | Purpose | ATT&CK |
|------|---------|--------|
| 01_network_connections.sql | Identify process behind C2 connection | T1095 |
| 02_process_tree.sql | Reconstruct execution chain | T1059.003 |
| 03_persistence.sql | Detect startup persistence | T1547.001 |
| 04_filesystem.sql | Locate payload in %TEMP% | T1036 |

## Key Findings
- pythonw.exe (PID 8492) maintained active connection to 192.168.1.138:4444
- Payload w_update.py confirmed in %TEMP% via process cmdline
- Persistence via win_log.vbs in Startup Folder (T1547.001)
- Dropper process (PID 8112) already terminated at investigation time — 
  illustrates OsQuery's lazy evaluation limitation

## Tools
OsQuery (osqueryi interactive mode), Windows 10 VM, Fedora Linux C2

## Notes
See [notes/limitations.md](notes/limitations.md) for architectural 
constraints identified during investigation.
