#Module 03: Process Management & Compilation 

## 1. Process Lifecycle and States
Based on the course materials, I have explored how Linux manages execution units.
- **Task:** Monitor and audit process states using automated tools.
- **Key Concept:** Identified the difference between **Foreground** and **Background** processes, and the importance of the **PID (Process ID)** for system management.

## 2. System Observation (The "Init" Conflict)
During this module, I identified a critical architectural difference in my laboratory (WSL2):
- **Finding:** The system uses `/init` as PID 1 instead of the standard `systemd`.
- **Resolution:** Adapted the audit scripts to handle cases where `systemctl` is not the primary init system, ensuring cross-environment compatibility.

## 3. Tooling: Process Guardian Script
I developed `process_guardian.sh` to automate three critical security and performance checks:
1. **Zombie Detection:** Identifies processes in 'Z' state to prevent resource exhaustion.
2. **Priority Audit:** Monitors processes with high `nice` values (potential resource hijackers).
3. **Service Integrity:** Checks for failed units in the service manager.

## 4. Compilation Workflow
Reflecting on the material, I documented the 4-stage tranformation:
`Pre-processing` -> `Compilation` -> `Assembly` -> `Linking`.
*Note: In production environments, I recommend restricting compilers like `gcc` to reduce the attack surface.*
