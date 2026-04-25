# OsQuery Limitations Identified in This Investigation

## 1. Lazy Evaluation — No Process History

OsQuery generates data at query time from the live system state.
Processes that have already terminated leave no trace in the `processes` table.

**Observed:** The dropper process (PID 8112) had exited before investigation began.
Its identity could not be confirmed through OsQuery alone.

**Recommendation:** Complement with Windows Event Log (Event ID 4688)
for full process creation history.

## 2. Incomplete Recursive File Traversal

The `file` table does not reliably traverse directories recursively.
Queries using path patterns may return empty results even when matching
files exist on disk.

**Observed:** Query for `.bat` files in the user profile returned no results,
despite the dropper having been executed from that location.

**Recommendation:** Use dedicated forensic tools (Autopsy, FTK Imager)
for complete filesystem analysis.

## 3. No Network Packet Inspection

OsQuery can identify socket connections but cannot inspect packet contents.
Commands exchanged between the backdoor and C2 server at the application
layer are not visible through OsQuery.

**Recommendation:** Pair with packet capture tools (Wireshark, Zeek)
or a network detection and response (NDR) solution.
