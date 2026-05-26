#!/usr/bin/env python3
import os

LOG_DIR = "Logs"
os.makedirs(LOG_DIR, exist_ok=True)
LOG_FILE_PATH = os.path.join(LOG_DIR, "diffie_hellman_key_sync.log")

def log_and_print(message):
	print (message)
	with open(LOG_FILE_PATH, "a", encoding="utf-8") as log_file:
		log_file.write(message + "\n")

def calculate_public_key(alpha, private_key, prime_q):
	return pow(alpha, private_key, prime_q)

def calculate_shared_secret(public_key_received, private_key, prime_q):
	return pow(public_key_received, private_key, prime_q)

def main():
	# Clear previous log file for clean execution
	if os.path.exists(LOG_FILE_PATH):
		os.remove(LOG_FILE_PATH)

	log_and_print("=" * 60)
	log_and_print("  DIFFIE-HELLMAN KEY EXCHANGE SIMULATION (MODULE 2)")
	log_and_print("=" * 60)

	# 1. Global Public Parameters (Agreed upon by Alice and Bob)
	q = 353
	a = 3
	log_and_print(f"[*] Global Public Parameters:")
	log_and_print(f"    - Prime modulus (q): {q}")
	log_and_print(f"    - Primitive root (a): {a}\n")

	# 2. Private Keys Generation
	Xa = 97   # Alice's private key
	Xb = 233  # Bob's private key
	log_and_print(f"[*] Private Keys (Kept Secret):")
	log_and_print(f"    - Alice's Private Key (Xa): {Xa}")
	log_and_print(f"    - Bob's Private Key (Xb): {Xb}\n")

	# 3. Public Keys Calculation
	log_and_print("[*] Calculating Public Keys...")
	Ya = calculate_public_key(a, Xa, q)
	Yb = calculate_public_key(a, Xb, q)
	log_and_print(f"    - Alice's Public Key (Ya sent to Bob): {Ya}  (Expected: 40)")
	log_and_print(f"    - Bob's Public Key (Yb sent to Alice): {Yb} (Expected: 248)\n")

	# 4. Shared Secret Derivation (Key Synchronization)
	log_and_print("[*] Exchanging Public Keys & Deriving Shared Secret...")
	Ka = calculate_shared_secret(Yb, Xa, q)
	Kb = calculate_shared_secret(Ya, Xb, q)

	log_and_print(f"    - Alice's Derived Secret (Ka): {Ka}")
	log_and_print(f"    - Bob's Derived Secret (Kb): {Kb}\n")

	# 5. Verification
	log_and_print("=" * 60)
	if Ka == Kb:
		log_and_print(f"[SUCCESS] Key Synchronization Complete!")
		log_and_print(f"Shared Secret Symmetric Key Verified: {Ka} (Expected: 160)")
	else:
		log_and_print("[ERROR] Key mismatch. Check parameters.")
		log_and_print("=" * 60)
		print (f"\n[INFO] Execution log saved to: {LOG_FILE_PATH}")

if __name__ == "__main__":
    main()
