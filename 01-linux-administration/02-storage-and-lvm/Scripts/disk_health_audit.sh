#!/bin/bash

#Storage Health & Inode Monitoring

LOG_FILE="../Logs/disk_health.log"

echo "--- [$(date)] DISK HEALTH AUDIT ---" > $LOG_FILE

#Inode Monitoring
echo -e "\n[!] Inode Usage Audit (Critical for small file enviroments):" >> $LOG_FILE
df -i | grep -E 'Filesystem|vg_lab' >> $LOG_FILE

#Bad Block Detection
echo -e "\n[!] Surface Sacn (Badblocks) on Virtual RAID Members:" >> $LOG_FILE
sudo badblocks -v /dev/loop10 2>&1 | tail -n 5 >> $LOG_FILE

#Actual Hardware Analysis (Notebook Specifications)
echo -e "\n[!] Underlaying Hardware Architecture (lscpu):" >> $LOG_FILE
lscpu | grep -E "Architecture|CPU\(s\)|Model name" >> $LOG_FILE

echo -e "\n--- AUDIT COMPLETE ---" >> $LOG_FILE
