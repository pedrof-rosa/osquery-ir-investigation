-- PURPOSE: Identify the process responsible for a suspicious outbound connection
-- WHEN TO USE: When an anomalous remote IP or port is detected on the endpoint
-- ATT&CK: T1095 - Non-Application Layer Protocol
--
-- RESULT (lab): pythonw.exe (PID 8492) confirmed active connection to IP

SELECT 
    lp.pid,
    p.name,
    p.cmdline,
    p.path,
    lp.remote_address,
    lp.remote_port,
    lp.state
FROM process_open_sockets AS lp
JOIN processes AS p ON lp.pid = p.pid
WHERE lp.remote_address = 'IP'
  AND lp.remote_port = 'Port';

-- Generic version: remove WHERE clause to list all established outbound connections
-- WHERE lp.state = 'ESTABLISHED'
