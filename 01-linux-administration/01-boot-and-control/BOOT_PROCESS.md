# Linux Boot Process & GRUB Analysis

**Lab Environment:** Debian GNU/Linux 13
**Plataform:** Oracle VM VirtualBox

This document details the initialization sequence of the Linux operating system and the specific hardware/software configuration observed.

## 1. System Components Observation
Using the `lscpu` and `lsblk` commands, I identified the following architecture:
* **CPU Model:** Intel(R) Core(TM) i5-1035G1 CPU @ 1.00GHz
* **Architecture:** x86_64
* **Storage Layout:** 20GB Virtual Disk (`/dev/sda`) with standard partitioning.

## 2. Bootloader Configuration (GRUB2)
I inspected the primary configuration file at `/etc/default/grub` and confirmed the following active parameters:
* **GRUB_DEFAULT=0**: Boots the first kernel entry.
* **GRUB_TIMEOUT=5**: 5-second window for user intervention.
* **GRUB_CMDLINE_LINUX_DEFAULT="quiet"**: Suppresses verbose kernel messages.

## 3. The Boot Process Chain
Based on the course material, the sequence follows:
1. **BIOS/UEFI**: Performs the POST (Power-On Self-Test).
2. **MBR/GPT**: Points to the Bootloader code.
3. **GRUB2**: Loads the Kernel and initrd.
4. **Kernel**: Mounts the Root Filesystem and initializes drivers.
5. **Systemd**: Final stage, starts system services (PID 1).

## 4. Security Hardening Concept
The GRUB menu currently allows parameter editing without authentication. 
**Recommendation:** Implement password protection to prevent unauthorized access to single-user mode or the root shell via boot parameter modification.
