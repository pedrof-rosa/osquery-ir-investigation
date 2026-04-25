-- PURPOSE: Locate payload and dropper files on the filesystem
-- WHEN TO USE: After identifying suspicious paths in process cmdlines
-- ATT&CK: T1036 - Masquerading (w_update.py mimics a legitimate system update)
--
-- RESULT (lab): .bat dropper not found via file table (recursive traversal limitation)
--               Payload w_update.py confirmed via process cmdline in query 02
--               See notes/limitations.md for explanation
-- Screenshot: ../screenshots/04_filesystem.png

-- Search for .bat dropper in user profile (may return empty — known OsQuery limitation)
SELECT path, filename, size
FROM file
WHERE path LIKE 'C:\\Users\\MCIF\\%%.bat';

-- Search for Python scripts in TEMP (common payload staging location)
SELECT path, filename, size
FROM file
WHERE path LIKE 'C:\\Users\\MCIF\\AppData\\Local\\Temp\\%%.py';
