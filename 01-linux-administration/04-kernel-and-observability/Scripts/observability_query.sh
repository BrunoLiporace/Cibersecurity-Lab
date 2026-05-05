#!/bin/bash

echo "--- HIGH PRIORITY ERRORS (Emerg, Alert, Crit) ---"
journalctl -p 0..2 --since "24 hours ago"

echo "--- SUSPICIOUS MODULE LOADING ATTEMPTS ---"
journalctl -k | grep -Ei "taint|unknown symbol|module load"
 
echo "--- LOG PERSISTENCE ---"
if [ -d "/var/log/journal" ]; then
	echo "Configuration: Persistent (Correct)"
else
	echo "Configuration: Volatile (Insecure - Logs are lost on reboot)"
fi
