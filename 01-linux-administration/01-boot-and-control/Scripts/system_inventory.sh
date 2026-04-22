#!/bin/bash

printf "=============================\n"
printf "Hardware Report\n"
printf "=============================\n"
printf "\n--> CPU INFORMATION\n"
lscpu | grep -E "Model Name|Architecture|CPU(s)"

printf "\n--> STORAGE DEVICES\n"
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT | column -t

printf "\n--> KERNEL & OS DETAILS\n"
uname -srm
