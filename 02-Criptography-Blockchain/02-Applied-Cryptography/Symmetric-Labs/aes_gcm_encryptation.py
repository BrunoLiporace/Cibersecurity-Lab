#!/usr/bin/env python3
import os
from Cryptodome.Cipher import AES

LOG_DIR = "Logs"
os.makedirs(LOG_DIR, exist_ok=True)
LOG_FILE_PATH = os.path.join(LOG_DIR, "aes_gcm_encryption.log")

def log_and_print(message):
	print (message)
	with open(LOG_FILE_PATH, "a", encoding="utf-8") as log_file:
		log_file.write(message + "\n")

def encrypt_payload(plaintext_bytes, key):
	log_and_print("[*] Initializing AES-GCM Cipher Pipeline...")
	# GCM generates a unique hardware nonce automatically
	cipher = AES.new(key, AES.MODE_GCM)
	ciphertext, tag = cipher.encrypt_and_digest(plaintext_bytes)

	log_and_print(f"[+] Nonce (IV) generated (Hex): {cipher.nonce.hex()}")
	log_and_print(f"[+] Authentication Tag generated (Hex): {tag.hex()}")
	return ciphertext, cipher.nonce, tag

def decrypt_payload(ciphertext, key, nonce, tag):
	log_and_print("[*] Initializing AES-GCM Decryption Pipeline...")
	cipher = AES.new(key, AES.MODE_GCM, nonce=nonce)
	try:
		# Decrypts and simultaneously verifies the MAC tag
		decrypted_data = cipher.decrypt_and_verify(ciphertext, tag)
		return decrypted_data
	except ValueError:
		log_and_print("[ALERT] Integrity Verification Failed! Tag mismatch.")
		return None

def main():
	if os.path.exists(LOG_FILE_PATH):
		os.remove(LOG_FILE_PATH)

	log_and_print("=" * 60)
	log_and_print("           AES-GCM SYMMETRIC ENCRYPTION LAB")
	log_and_print("=" * 60)

	# 1. Secret Shared Key Generation (AES-256 requires 32 bytes)
	secret_key = os.urandom(32)
	log_and_print(f"[+] Generated Random 256-bit Symmetric Key: {secret_key.hex()}")

	# 2. Plaintext Setup
	raw_message = b"Top Secret: Operations framework deployed on Linux production cluster."
	log_and_print(f"[+] Plaintext Message: '{raw_message.decode()}'")

	# 3. Encryption Flow
	ciphertext, nonce, tag = encrypt_payload(raw_message, secret_key)
	log_and_print(f"[+] Ciphertext Output (Hex): {ciphertext.hex()[:50]}...")

	# 4. Success Decryption Flow
	log_and_print("\n--- SCENARIO 1: Authorized Decryption ---")
	recovered = decrypt_payload(ciphertext, secret_key, nonce, tag)
	if recovered:
		log_and_print(f"[SUCCESS] Integrity Verified! Recovered: '{recovered.decode()}'")

	# 5. Tampering Flow (Attacker modifies 1 byte of the ciphertext)
	log_and_print("\n--- SCENARIO 2: Ciphertext Tampering Attack ---")
	corrupted_ciphertext = bytearray(ciphertext)
	corrupted_ciphertext[0] ^= 0xFF  # Flip bits of the very first byte
	log_and_print("[!] Attacker modified the ciphertext in transit...")

	failed_recovery = decrypt_payload(bytes(corrupted_ciphertext), secret_key, nonce, tag)
	if not failed_recovery:
		log_and_print("[ALERT] Security Control Active: Data rejected due to corruption.")

	log_and_print("=" * 60)
	print (f"\n[INFO] Local log saved to: {LOG_FILE_PATH}")

if __name__ == "__main__":
    main()

