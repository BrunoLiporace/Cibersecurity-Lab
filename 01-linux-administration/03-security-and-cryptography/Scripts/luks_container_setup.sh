#!/bin/bash

CONTAINER="/opt/container.img"
MAPPER_NAME="secure_drive"
MOUNT_POINT="/mnt/secure_data"

echo "[*] Creating 100MB container"
dd if=/dev/urandom of=$CONTAINER bs=1M count=100

echo "[*] Formatting with LUKS"
sudo cryptsetup luksOpen $CONTAINER

echo "[*] Opening volume"
sudo cryptsetup luksOpen $CONTAINER $MAPPER_NAME

echo "[*] Creating ext4 filesystem"
sudo mkfs.ext4 /dev/mapper/$MAPPER_NAME

echo "[*] Mounting to $MOUNT_POINT"
sudo mkdir -p $MOUNT_POINT
sudo mount /dev/mapper/$MAPPER_NAME $MOUNT_POINT

echo "[*] Success. Files in $MOUNT_POINT are encrypted at rest."
