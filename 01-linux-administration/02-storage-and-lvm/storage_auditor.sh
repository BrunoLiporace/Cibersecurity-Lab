#!/bin/bash

LOG_FILE="storage_report.log"

echo ""
echo "----[$(date) STORAGE & LVM AUDIT START ----]" > $LOG_FILE
echo "System: $(hostnamectl | grep "Operatin System" | cut -d: -f2)" >> $LOG_FILE

echo ""
echo "[!] Block Device Mapping:" >> $LOG_FILE
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT >> $LOG_FILE


echo ""
echo "[!] Raid 1 Status (Redundancy Check):" >> $LOG_FILE
if [ -f /proc/mdstat ]; then
	cat /proc/mdstat >> $LOG_FILE
	sudo mdadm --detail /dev/md0 | grep -E "State | Actib7/b6b6ve Devices | Working Devices" >> $LOG_FILE
else
	echo ""
	echo "ERROR: Raid not detected." >> $LOG_FILE
fi

echo ""
echo "[!] LVM Layer Audit:" >> $LOG_FILE
echo "---- Physical Volumes ----" >> $LOG_FILE
sudo pvs >> $LOG_FILE
echo "---- Volume Groups ----" >> $LOG_FILE
sudo vgs >> $LOG_FILE
echo "---- Logical Volumes ----" >> $LOG_FILE
sudo lvs >> $LOG_FILE

echo ""
echo "[!] Mount Point Security Audit:" >> $LOG_FILE
mount | grep "/mnt/secure_storage" >> $LOG_FILE

echo ""
echo "---- [$(date)] AUDIT COMPLETE ----" >> $LOG_FILE
