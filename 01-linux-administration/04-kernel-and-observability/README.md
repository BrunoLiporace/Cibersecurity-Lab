# Kernel Administration & Observability (LKM & Systemd)
This module covers advanced Linux Kernel management, Loadable Kernel Module (LKM) handling, and the implementation of observability strategies for anomaly detection.
## 1.Kernel Architecture
Linux utilizes a **Hybrid Monolithic** design. Unlike microkernels, system services and device drivers execute in **Ring 0** (privileged memory space).
- **Advantage:** High performance.
- **Risk:** A failure in a single module (Kernel Panic) compromises the entire system stability.

## 2.Module Management (LKM)
*Loadable Kernel Modules* (.ko) allow for extended functionality without requiring a system reboot.
- `lsmod`: Queries the status of modules via `/proc/modules`.
- `modprobe`: Intelligent loading/unloading that manages dependencies.
- **Hardening:** Utilization of `/etc/modprobe.d/blacklist.conf` to disable insecure protocols (e.g, DCCP, SCTP, Firewire).

## 3.Observability with Systemd-Journald
Journald collects binary logs from both the kernel and user processes
* **Critical Command:** `journalctl -k` for exclusive kernel ring buffer messages (dmesg).
* **JSON Format:** Vital for integration with SIEM platforms (Splunk/ELK).
	* `journalctl -u ssh -o json-pretty`

