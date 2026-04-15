#Resilient Storage Architecture: RAID 1 + LVM Hardening

## 1. Project Overview
This laboratory demonstrates the implementation of a source and redundant storage infrastructure on **Debian 13**. The project focuses on overcoming physical hardware limitations through **Loop Device abstraction** while implementing industry-standard data integrity and system hardening.

## 2. Theoretical Framework & Implementation

### Phase I: Storage Abstraction (Loop Devices)
Since the host environment (Notebook) possesses a single physical drive, I utilized `dd` and `losetup` to create two independent block devices (`/dev/loop10`, `/dev/loop11`) of 1GB each. This simulates a multi-disk server environment.

### Phase II: Data Redundancy (RAID 1)
Using `mdadm`, a **RAID 1 (Mirroring)** array was constructed.
* **Purpose:** To ensure Business Continuity. By mirroring data across two devices, the system remains operational even if one "physical" device fails.
* **Verification:** The `storage_report.log` confirms the array `/dev/md0` is in an `active` state with 2 synchronized devices.



### Phase III: Logical Volume Management (LVM2)
I implemented a three-tier LVM hierarchy over the RAID array to provide storage elasticity:
1.  **PV (Physical Volume):** Initialized `/dev/md0` as the underlying physical resource.
2.  **VG (Volume Group):** Created `vg_lab`, a logical pool that aggregates the redundant storage.
3.  **LV (Logical Volume):** Carved `lv_data` (500MB) to serve as the final mountable partition.

## 3. Security Hardening & Mount Policy
As per **Security Best Practices**, the logical volume was formatted with `EXT4` and mounted at `/mnt/secure_storage` using strict restrictive flags (Reference: *Montajes de medios.pdf*):

| Flag | Security Impact |
| :--- | :--- |
| `noexec` | Prevents binary execution, neutralizing potential malware payloads. |
| `nosuid` | Disables set-user-identifier bits, preventing unauthorized privilege escalation. |
| `nodev` | Prevents the system from interpreting character or block special devices. |

## 4. Auditor Evidence
The automated audit tool `storage_auditor.sh` generated the following evidence:
* **RAID Integrity:** Confirmed `State: clean`.
* **LVM Mapping:** Successfully mapped `lv_data` back to the RAID-backed VG.
* **Mount Verification:** Confirmed that the security flags are active in the kernel's mount table.

---
**Note:** This architecture follows the "Zero Complacency" principle, ensuring that storage is not only available but also inherently resistant to common execution-based attack vectors.
