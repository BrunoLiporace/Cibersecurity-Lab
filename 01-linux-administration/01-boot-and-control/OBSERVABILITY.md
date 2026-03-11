# System Observability & Logging

In cybersecurity, logs are the primary source of truth for incident investigation. This document outlines how to use `journald` to monitor security events.

### ritical Investigative Commands

1. **View High-Priority Errors:**
   `sudo journalctl -p 3 -xb`
   *Shows only errors (Priority 3) from the current boot. Essential for rapid troubleshooting.*

2. **Monitor User Sessions & Logins:**
   `sudo journalctl -u systemd-logind`
   *Used to track login/logout events, which is critical for identifying unauthorized access.*

3. **Check Specific Service Logs:**
   `sudo journalctl -u [service_name]`
   *Allows deep inspection of a specific daemon's behavior.*

4. **Real-time Event Tracking:**
   `sudo journalctl -f`
   *Follows the log output in real-time, ideal for live monitoring during an attack or system failure.*
