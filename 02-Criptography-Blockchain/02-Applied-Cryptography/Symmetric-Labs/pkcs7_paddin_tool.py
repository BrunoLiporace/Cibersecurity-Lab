#!/usr/bin/env python3
import os

LOG_DIR = "Logs"
os.makedirs(LOG_DIR, exist_ok=True)
LOG_FILE_PATH = os.path.join(LOG_DIR, "pkcs7_padding_tool.log")

def log_and_print(message):
	print(message)
	with open(LOG_FILE_PATH, "a", encoding="utf-8") as log_file:
		log_file.write(message + "\n")

def pkcs7_pad(data_bytes, block_size=16):
	padding_len = block_size - (len(data_bytes) % block_size)
	# Generate the padding string (N bytes of value N)
	padding = bytes([padding_len] * padding_len)
	padded_data = data_bytes + padding

	log_and_print(f"    [-] Data Length: {len(data_bytes)} bytes")
	log_and_print(f"    [-] Required Pad: {padding_len} bytes")
	log_and_print(f"    [-] Padding Bytes Added (Hex): {padding.hex()}")
	return padded_data

def pkcs7_unpad(padded_bytes, block_size=16):
	if len(padded_bytes) == 0 or len(padded_bytes) % block_size != 0:
		raise ValueError("Invalid block alignment.")
	# Read the numerical value of the very last byte
	padding_len = padded_bytes[-1]

	# Validation: Ensure all padding bytes share the exact same value
	if padding_len == 0 or padding_len > block_size:
		raise ValueError("Invalid padding length indicator.")

	for i in range(len(padded_bytes) - padding_len, len(padded_bytes)):
		if padded_bytes[i] != padding_len:
			raise ValueError("Corrupted padding structure detected.")

	# Strip the padding away
	return padded_bytes[:-padding_len]

def main():
	if os.path.exists(LOG_FILE_PATH):
		os.remove(LOG_FILE_PATH)

	log_and_print("=" * 60)
	log_and_print("          PKCS#7 MANUAL PADDING LABORATORY")
	log_and_print("=" * 60)

	# Test 1: Data that leaves free space in the block (similar to the PDF example)
	log_and_print("[*] CASE 1: Processing unaligned text string (10 bytes of data)...")
	data_case1 = b"1234567890"  # 10 bytes. Needs 6 bytes of 0x06 to hit 16 bytes.

	padded_1 = pkcs7_pad(data_case1, block_size=16)
	log_and_print(f"[+] Resulting Block Payload (Hex): {padded_1.hex()}")

	unpadded_1 = pkcs7_unpad(padded_1, block_size=16)
	log_and_print(f"[SUCCESS] Stripped text plano recovered: '{unpadded_1.decode()}'\n")

	# Test 2: Data that is already an exact multiple of the block size
	log_and_print("[*] CASE 2: Processing data matching exact block length (16 bytes)...")
	data_case2 = b"A_PERFECT_BLOCK!"  # Exact 16 bytes. Must append an entire 16-byte block of 0x10.

	padded_2 = pkcs7_pad(data_case2, block_size=16)
	log_and_print(f"[+] Resulting Block Payload (Hex): {padded_2.hex()}")

	unpadded_2 = pkcs7_unpad(padded_2, block_size=16)
	log_and_print(f"[SUCCESS] Stripped text plano recovered: '{unpadded_2.decode()}'\n")

	# Test 3: Detecting Corrupted Padding (Security Verification)
	log_and_print("[*] CASE 3: Simulating Padding Tampering Detection...")
	malicious_payload = bytearray(padded_1)
	malicious_payload[-1] = 0x99  # Corrupting the padding structure intentionally

	log_and_print(f"[!] Target payload under validation (Hex): {malicious_payload.hex()}")
	try:
		pkcs7_unpad(bytes(malicious_payload), block_size=16)
		log_and_print("[ERROR] Failed to trap corrupted padding structural integrity.")
	except ValueError as err:
		log_and_print(f"[ALERT] Integrity Breach Identified! Error: {err}")

	log_and_print("=" * 60)
	print (f"\n[INFO] Local log saved to: {LOG_FILE_PATH}")

if __name__ == "__main__":
    main()
