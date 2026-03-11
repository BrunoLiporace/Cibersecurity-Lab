# System Observability & Logging

In cybersecurity, logs are the primary source of truth for incident investigation. This document outlines how to use `journald` to monitor security events.

### Critical Investigative Commands

1. **View High-Priority Errors:**
   `sudo journalctl -p 3 -xb --no-pager`
   *Shows only errors (Priority 3) from the current boot. Essential for rapid troubleshooting.*

2. **Monitor User Sessions & Logins:**
   `sudo journalctl -u systemd-logind`
   *Used to track login/logout events, which is critical for identifying unauthorized access.*


3. **Real-time Event Tracking:**
   `sudo journalctl -f`
   *Follows the log output in real-time, ideal for live monitoring during an attack or system failure.*

---

## Network & User Session Forensics

As part of the **Integrated Project**, we monitor network integrity and user session persistence to prevent unauthorized lateral movement.

### 1. Network Interface Audit
If `systemd-networkd` is the primary manager, we use:
`networkctl status`
* **To verify if an interface is "routable" or if there's a misconfiguration in the virtual bridge (common in WSL2/Cloud environments).**

### 2. Session Investigation (loginctl)
To see who is currently attached to the system and their process impact:
* **List Active Sessions:** `loginctl list-sessions`
* **User Sessions Tree:** `loginctl user-status [username]`
  *This command is vital to see if a user has left "hidden" processes running after thei sessions was supposed to end.*
