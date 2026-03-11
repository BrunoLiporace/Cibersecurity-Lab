# 01 - Boot, System Control & Localization

Technical documentation and automation tools regarding system startup, service management (systemd), and regional configurations

## Contents

### Module 1: Boot & Hardware
* **[system_inventory.sh](./system_inventory.sh):** Hardware detection and architecture audit script
* **[BOOT_PROCESS.md](./BOOT_PROCESS.md):** Detailed analysis of GRUB2 and the initialization sequence

### Module 2: System Management & Time
* **[system_manager.sh](./system_manager.sh):** Administrative tool for auditing service health, NTP sync, and boot performance
* **[system_audit.log](./system_audit.log):** Real-world output from the audit execution (Generated on March 10, 2026)
* **[OBSERVABILITY.md](./OBSERVABILITY.md):** Reference guide for system logging and forensics using `journalctl`
