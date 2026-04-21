# 02 - Storage & LVM Architecture

This directory contains technical research, automation script, and implementation evidence regarding advanced storage management, data redundancy and system hardening in Linux enviroments.

## Contents
* **[STORAGE_ARCH.md](./STORAGE_ARCH.md):** Technical deep-dive into the RAID 1 + LVM stack.
* **[LINKS_AND_INODES.md](./LINKS_AND_LINKS.md):** Evidence-based analysis of Inode pointers and file linking (Hard vs. Soft links).
* **[storage_auditor.sh](./storage_auditor.sh):** Automation script for RAID status and LVM mapping.
* **[disk_health_audit.sh](./disk_health_audit.sh):** Diagnostic tool for Inode health and physical surface verification (badblocks).
* **[storage_report.log](./storage_report.log):** Real execution logs from the Debian 13 server.

---

## Key Learning Milestones

### 1. Data Redundancy & Elasticity
Implementation of **RAID 1 (Mirroring)** and **LVM2** layers to ensure high availability and non-disruptive storage scaling.

### 2. File System Deep-Dive (Inodes)
Practical verification of Inodes management. By mapping hard links and symbolic links, I demonstrated how the Linux Kernel handles data pointers at the filesystem level.
* **Verified Inode:** 53477379 (Shared across Hard Links).

### 3. Advanced Diagnostic & Hardening
* **Health Monitoring:** Use of `df -i` to prevent "Inode Exhaustion" (Local DoS) and ``badblocks` for integrity verification.
* **Security Policy:** Volumes mounted with `noexec`, `nosuid`, and `nodev` to reduce the attack surface.

## Tech Stack
* **OS:** Debian 13 (Headless/SSH).
* **Tools:** `mdadm`, `lvm2`, `losetup`, `badblocks`, `stat`.

