#!/bin/bash

set -e

USER_ID="security_admin"

case "$1" in
	gen)
		echo "[*] Generating RSA 4096 key pair (Security Standard)..."
		gpg --batch --generate-key <<EOF
Key-Type: RSA
Key-Length: 4096
Name-Real: $USER_ID
Expire-Date: 0
%no-protection
%commit
EOF
		;;
	encrypt)
		if [ -z "$2" ]; then echo "[-] Usage: $0 ecrypt <file>"; exit 1; fi
		gpg --encrypt --recipient "$USER_ID" "2"
		echo "[+] File $2 successfully encrypted."
		;;
	sign)
		if [ -z "$2" ]; then echo "[-] Usage: $0 sign <file>"; exit 1; fi
		gpg --clearsign "$2"
		echo "[+] Signature generated for $2."
		;;
	*)
		echo "Usage: $0 {gen|ecrypt|sign}"
		;;
esac
