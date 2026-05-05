# Cryptography and Secure Storage Management

This laboratory implements a **Defense in Depth** architecture through data-at-rest encryption and the automation of critical backups

## Implemented Tools

### 1. GnuPG (Asymmetric Privacy)
- **Script:** `gpg_vault_manager.sh`
- **Function:** Generation of cryptographic identities (RSA 4096-bit) for encryption and digital signatures.
- **Use Case:** Protection of files in transit and integrity verification of administratives scripts.

### 2. LUKS - Linux Unified Key Setup
- **Script:** `luks_container_setup.sh`
- **Function:** Creation of an encrypted block volume based on a container file (`/opt/container.img`).
- **Security:** Implements AES encryption at the partition level. Protects confidentiality against unauthorized physical access or disk extraction.

### 3. Backup Automation (Cron)
A scheduled task has been configured to ensure data availability.
- **Secure Pipeline:** The backup is bundled using `tar`and ecrypted "on-the-fly" with `gpg`before being written to disk, mitigating forensic recovery riks in temporary directories.

---

## Operation Guide (Cheat Sheet)

### LUKS Container Management:
- **Open and Mount:**
  ```bash
  sudo cryptsetup luksOpen /opt/container.img secure_drive
  sudo mount /dev/mapper/secure_drive /mnt/secure_data
