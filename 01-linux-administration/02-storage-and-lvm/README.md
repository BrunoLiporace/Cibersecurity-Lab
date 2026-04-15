# 02 - Storage & LVM Architecture

This directory contains technical research, automation script, and implementation evidence regarding advanced storage management, data redundancy and system hardening in Linux enviroments.

## Contents
* **[STORAGE_ARCH.md](./STORAGE_ARCH.md):** Detailed technical documentation of the RAID 1 + LVM hierarchy implemented in a Debian 13 enviroment.
* **[storage_auditor.sh](./storage_auditor.sh):** A bash script designed to audit block devices, RAID status, and LVM layers.
* **[storage_report.log](./storage_report.log):** Real-audit output proving the successful implementation of redundant and secure storage.

---

## Key Learning Milestones

### 1. Hardware Abstraction:
Creation of simulated block devices using `dd` and `losetup` to bypass physical storage constraints.

### 2. Data Redundancy (RAID 1)

Ensuring high availability on the Debian 13 server by mirroring data across simulated devices.

### 3. Logical Volume Management (LVM2)
Implementation of an elastic storage layer to manage data volumes dynamically via SSH.

