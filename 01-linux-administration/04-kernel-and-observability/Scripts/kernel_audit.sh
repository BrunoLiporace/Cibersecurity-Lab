#!/bin/bash
#Standards: NIST SP 800-123

set -e

LOG_FILE="kernel_audit_$(date +%Y%m%d).log"

echo "[+] Starting Kernel audit: $(date)" | tee -a "$LOG_FILE"

echo "[*] Listing active modules..." >> "$LOG_FILE"
lsmod | awk 'NR>1 {print $1}' > loaded_modules.txt

TAINT_STATUS=$(cat /proc/sys/kernel/tainted)
if [ "$TAINT_STATUS" -ne 0 ]; then
	echo "[!] WARNING: Kernel is TAINTED (Code: $TAINT_STATUS). Possible unverified module detected." | tee -a "$LOG_FILE"
else
	echo "[+] Kernel Integrity: OK" | tee -a "$LOG_FILE"
fi

if lsmod | grep -q "usb_storage"; then
	echo "[!] ALERT: 'usb_storage' module detected. Risk of physical data exfiltration." | tee -a "$LOG_FILE"
fi

echo "[*] Extracting hardware and kernel errors from the last 2 hours..." >> "$LOG_FILE"
journalctl -k --since "2 hours ago" -p 0..3 >> "$LOG_FILE"

echo "[+] Audit complete. Results saved in $LOG_FILE"
