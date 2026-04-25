-- PURPOSE: Reconstruct the process execution chain from a suspicious process
-- WHEN TO USE: After identifying a malicious PID in step 01
-- ATT&CK: T1059.003 - Windows Command Shell
--
-- RESULT (lab): cmd.exe (PID 7364, parent 8112) launched pythonw.exe with w_update.py
--               Parent PID 8112 already terminated — dropper had exited
-- Screenshot: ../screenshots/02_process_tree.png

-- Step 1: Find cmd.exe instances and their parents
SELECT pid, name, cmdline, parent 
FROM processes 
WHERE name = 'cmd.exe';

-- Step 2: Trace parent PID (replace with actual parent PID from step 1)
-- Empty result = process already terminated. See notes/limitations.md
SELECT pid, name, cmdline, parent 
FROM processes 
WHERE pid = '8112';

-- Step 3: Confirm payload path via cmdline
SELECT pid, path, cmdline 
FROM processes 
WHERE path LIKE '%pythonw.exe%';
