# 01 - Boot, System Control & Localization

Technical documentation and automation tools regarding system startup, service management (systemd), and regional configurations

## Contents

### Module 1: Boot & Hardware
* **[system_inventory.sh](./Scripts/system_inventory.sh):** Hardware detection and architecture audit script
* **[BOOT_PROCESS.md](./BOOT_PROCESS.md):** Detailed analysis of GRUB2 and the initialization sequence

### Module 2: System Management & Time
* **[system_manager.sh](./Scripts/system_manager.sh):** Core audit script for performance, NTP, and services.
* **[system_audit.log](./Logs/system_audit.log):** Real-world output from the audit execution (Generated on March 10, 2026)
* **[OBSERVABILITY.md](./OBSERVABILITY.md):** Reference guide for system logging (journalctl), network (networkctl) and sessions (loginctl)

### Module 3: Process Management & Compilation
* **[process_guardian.sh](./Scripts/process_guardian.sh):** Automation tool for process auditing and system health.
* **[process_audit.log](./Logs/process_audit.log):** Audit evidence (Zombie detection, Nice values, Service status).
* **[PROCESS_MANAGEMENT.md](./PROCESS_MANAGEMENT.md):** Technical deep-dive into process lifecycle and the C comilation workflow.

---

## Technical Stack & Enviroment
* **OS:** Ubuntu 24.04 LTS (via WSL2).
* **Shell:** Bash.

## Key Achievements
* **Process Security:** Implemented automated detection of Zombie processes and high-priority resource hijackers.
* **Architecture Awareness:** Documented the transition from `/init` (WSL2) to standard `systemd` enviroments.
* **Supply Chain Security:** Analyzed the 4-stage compilation process and its implications on server hardening.
