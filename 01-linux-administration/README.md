# Linux Administration

This repository section focuses on Debian system administration, structured to meet the requirements of the **Integrated Project** roadmap.

## Integrated Project Overview
The primary objective is the implementation, management, and hardening of a corporate-grade server environment. Each block within this directory represents a critical phase of the project's development.

## Strategic Infrastructure Blocks

### 1.Boot and System Control
*Location: `01-boot-and-control/`*
* **Core Focus:** Bootloader analysis (GRUB2), system localization, and process management via `systemd`.

### 2.Storage and LVM Architecture
*Location: `02-storage-and-lvm/`*
* **Core Focus:** Filesystem administration, Logical Volume Management (LVM), and storage quotas.

### 3.Security and Cryptography
*Location: `03-security-and-crypto/`*
* **Core Focus:** System hardening, data encryption, and security auditing.

### 4.Kernel and Observability
*Location: `04-kernel-and-observability/`*
* **Core Focus:** Kernel management, compilation, and advanced log/event monitoring.

## Laboratory Environment (Home Lab)

Unlike standard virtualized enviroments, the practices in this repository are executed on a **dedicated Physical Server (Bare Metal)**:

* **Hardware:** Legacy Notebook repurposed as a Headless Server.
* **OS:** Debian 13 (Trixie) - Minimal Installation (CLI only).
* **Management:** Fully headless administration via **SSH** (Secure Shell).
* **Purpose:** Testing real-world hardware constraints, storage redundancy, and remote security auditing.

