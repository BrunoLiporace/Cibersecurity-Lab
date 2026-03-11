#!/bin/bash

echo "-----------------------------"
echo "   Starting System Audit"
echo "-----------------------------"

echo ""
echo "1. Boot Performance"
systemd-analyze

echo ""
echo "Top 5 slowest services:"
systemd-analyze blame | head -n 5

echo ""
echo "2. Time & NTP Status"
timedatectl | grep -E "Time zone|System clock synchronized|NTP service"

echo ""
echo "3. Current Locales"
localectl status

echo ""
printf "4. Failed Services Check"
FAILED_COUNT=$(systemctl --failed | grep -c "loaded units listed")

if [ "$FAILED_COUNT" -eq 1 ]; then
	echo ""
	echo "All services are runnning correctly"
else 
	systemctl --failed
fi

echo ""
echo "--------------------------------"
echo "        AUDIT COMPLETE"
echo "--------------------------------"

