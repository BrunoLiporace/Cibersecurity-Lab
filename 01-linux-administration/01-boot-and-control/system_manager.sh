#!/bin/bash

echo "-----------------------------"
echo "   Starting System Audit"
echo "-----------------------------"

echo ""
echo "[1] Boot Performance"
systemd-analyze

echo ""
echo "Top 5 slowest services:"
systemd-analyze blame | head -n 5

echo ""
echo "[2] Time & NTP Status"
timedatectl | grep -E "Time zone|System clock synchronized|NTP service"

echo ""
echo "[3] Current Locales"
localectl status

echo ""
echo "[4] Failed Services Check"
FAILED_COUNT=$(systemctl --failed | grep -c "loaded units listed")

if [ "$FAILED_COUNT" -eq 1 ]; then
	echo ""
	echo "All services are runnning correctly"
else 
	systemctl --failed
fi

echo ""
echo "[5] Network Interface Status"
if systemctl is-active --quiet systemd-networkd; then
	networkctl status | grep -E "State|Adress"
else
	echo ""
	echo "Note: systemd-networkd is inactive (Standard in WSL2)"
	echo "Active IPv4 Addresses:"
	ip -4 addr show | grep inet | grep -v "127.0.0.1" | awk '{print " Interface: " $NF " | Address: " $2}'
fi

echo ""
echo "[6] Active User Sessions"
loginctl list-sessions
echo ""
echo "Detailed session info for current user ($USER):"
loginctl user-status $USER | head -n 5

echo ""
echo "--------------------------------"
echo "        AUDIT COMPLETE"
echo "--------------------------------"

