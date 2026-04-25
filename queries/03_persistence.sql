-- PURPOSE: Detect persistence mechanisms configured to survive reboot or logon
-- WHEN TO USE: After identifying a malicious process — check what survives restart
-- ATT&CK: T1547.001 - Boot or Logon Autostart: Startup Folder
--
-- RESULT (lab): win_log.vbs found in Startup Folder, enabled for user MCIF
--               No malicious scheduled tasks found — attacker used lower-privilege method
-- Screenshot: ../screenshots/03_persistence.png

-- Check startup items (Startup Folder + registry run keys)
SELECT * FROM startup_items;

-- Cross-check with scheduled tasks
-- Absence of malicious entries confirms Startup Folder as sole persistence mechanism
SELECT * FROM scheduled_tasks;
