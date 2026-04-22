#!/bin/bash

LOG_FILE="../Logs/process_audit.log"

echo ""
echo "--- [$(date)] PROCESS AUDIT START ---" > $LOG_FILE

check_zombies() {
	echo "[!] Searching for Zombie processes."
	ZOMBIES=$(ps -el | awk '$2=="Z" {print $4}')
	if [ -z "$ZOMBIES" ]; then
		echo "OK: No Zombie processes detected." >> $LOG_FILE
	else
		echo "WARN: Zombie processes detected (PIDs): $ZOMBIES" >> $LOG_FILE
	fi
}

check_high_priority() {
	echo "[!] Analyzing Process Priotities (Nice)."
	echo "Top 10 High-Priority Processes:" >> $LOG_FILE
	ps -eo pid,ni,comm --sort=ni | head -n 11 >> $LOG_FILE
}

check_failed_services(){
	echo "[!] Cheking system services (systemctl)."
	FAILED=$(systemctl list-units --state=failed --no-legend 2>/dev/null)
	if [ -z "$FAILED" ]; then
		echo "OK: All systemd services are operational or systemd not present." >> $LOG_FILE
	else
		echo "CRITICAL: Failed services detected:" >> $LOG_FILE
		echo "$FAILED" >>$LOG_FILE
	fi
}

check_zombies
check_high_priority
check_failed_services

echo "--- [$(date)] AUDIT END ---" >> $LOG_FILE
echo "Process audit completed. Check $LOG_FILE for details."
