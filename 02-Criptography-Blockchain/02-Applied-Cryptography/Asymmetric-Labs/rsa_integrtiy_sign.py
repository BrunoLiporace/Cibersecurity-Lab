#!/usr/bin/env python3
import os
import sys
from Cryptodome.PublicKey import RSA
from Cryptodome.Hash import SHA256
from Cryptodome.Signature import pss

LOG_DIR = "Logs"
os.makedirs(LOG_DIR, exist_ok=True)
LOG_FILE_PATH = os.path.join(LOG_DIR, "rsa_integrity_sign.log")

def log_and_print(message):
	print(message)
	with open(LOG_FILE_PATH, "a", encoding="utf-8") as log_file:
		log_file.write(message + "\n")

def generate_key_pair():
	log_and_print("[*] Generating 2048-bit RSA key pair...")
	key = RSA.generate(2048)
	private_key = key.export_key()
	public_key = key.public_key().export_key()
	return private_key, public_key

def sign_message(message_bytes, private_key_pem):
	log_and_print("[*] Alice: Hashing and signing the message...")
	key = RSA.import_key(private_key_pem)
	msg_hash = SHA256.new(message_bytes)
	signature = pss.new(key).sign(msg_hash)
	return signature

def verify_signature(message_bytes, signature, public_key_pem):
	log_and_print("[*] Bob: Verifying signature integrity...")
	key = RSA.import_key(public_key_pem)
	msg_hash = SHA256.new(message_bytes)
	try:
		pss.new(key).verify(msg_hash, signature)
		return True
	except (ValueError, TypeError):
		return False

def main():
	# Clear previous log file for clean execution
	if os.path.exists(LOG_FILE_PATH):
		os.remove(LOG_FILE_PATH)
	log_and_print("=" * 60)
	log_and_print("      RSA DIGITAL SIGNATURE AND INTEGRITY LAB")
	log_and_print("=" * 60)

	# 1. Setup Identities
	alice_private_key, alice_public_key = generate_key_pair()

	# 2. Original Payload
	original_data = b"CONFIDENTIAL: Transfer $5000 to account UTF-8."
	log_and_print(f"\n[+] Original Payload: '{original_data.decode()}'")

	# 3. Signature Generation
	signature = sign_message(original_data, alice_private_key)
	log_and_print(f"[+] Digital Signature generated successfully (Hex): {signature.hex()[:40]}...")

	# 4. Transmission & Successful Verification
	log_and_print("\n--- SCENARIO 1: Intact Transmission ---")
	is_valid = verify_signature(original_data, signature, alice_public_key)
	if is_valid:
		log_and_print("[SUCCESS] Signature is VALID. Integrity and authenticity verified!")
	else:
		log_and_print("[FAILURE] Invalid Signature.")

	# 5. Tampering Attempt (MITM)
	log_and_print("\n--- SCENARIO 2: Integrity Breach (MITM Attack) ---")
	tampered_data = b"CONFIDENTIAL: Transfer $9000 to account UTF-8."
	log_and_print (f"[!] Attacker changes payload to: '{tampered_data.decode()}'")

	is_valid_tampered = verify_signature(tampered_data, signature, alice_public_key)
	if not is_valid_tampered:
		log_and_print ("[ALERT] VERIFICATION FAILED! The payload was modified in transit.")
	else:
		log_and_print("[ERROR] Security breach undetected.")
		log_and_print("=" * 60)
		print (f"\n[INFO] Execution log saved to: {LOG_FILE_PATH}")

if __name__ == "__main__":
    main()
