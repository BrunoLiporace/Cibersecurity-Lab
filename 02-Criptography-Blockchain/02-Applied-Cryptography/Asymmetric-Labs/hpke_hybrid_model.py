#!/usr/bin/env python3
import os
from Cryptodome.PublicKey import RSA
from Cryptodome.Cipher import PKCS1_OAEP, AES

LOG_DIR = "Logs"
os.makedirs(LOG_DIR, exist_ok=True)
LOG_FILE_PATH = os.path.join(LOG_DIR, "hpke_hybrid_model.log")

def log_and_print(message):
	print (message)
	with open(LOG_FILE_PATH, "a", encoding="utf-8") as log_file:
		log_file.write(message + "\n")

def generate_bob_recipient_keys():
	key = RSA.generate(2048)
	return key.export_key(), key.public_key().export_key()

def alice_hybrid_encrypt(plain_text, bob_public_key_pem):
	log_and_print("\n[*] --- Alice Side: Encrypting Flow ---")
	session_key = os.urandom(32)
	log_and_print(f"[+] Generated Random AES Session Key: {session_key.hex()}")

	log_and_print("[+] Encrypting payload using fast AES-GCM...")
	aes_cipher = AES.new(session_key, AES.MODE_GCM)
	ciphertext, tag = aes_cipher.encrypt_and_digest(plain_text.encode())
	nonce = aes_cipher.nonce

	log_and_print("[+] Encrypting the AES Session Key using Bob's RSA Public Key...")
	bob_rsa_key = RSA.import_key(bob_public_key_pem)
	rsa_cipher = PKCS1_OAEP.new(bob_rsa_key)
	encrypted_session_key = rsa_cipher.encrypt(session_key)

	return encrypted_session_key, nonce, ciphertext, tag

def bob_hybrid_decrypt(encrypted_bundle, bob_private_key_pem):
	log_and_print("\n[*] --- Bob Side: Decrypting Flow ---")
	encrypted_session_key, nonce, ciphertext, tag = encrypted_bundle

	log_and_print("[+] Decrypting the AES Session Key using Bob's RSA Private Key...")
	bob_rsa_key = RSA.import_key(bob_private_key_pem)
	rsa_cipher = PKCS1_OAEP.new(bob_rsa_key)
	decrypted_session_key = rsa_cipher.decrypt(encrypted_session_key)
	log_and_print(f"[+] Recovered AES Session Key: {decrypted_session_key.hex()}")

	log_and_print("[+] Decrypting bulk payload using AES-GCM...")
	aes_cipher = AES.new(decrypted_session_key, AES.MODE_GCM, nonce=nonce)
	decrypted_data = aes_cipher.decrypt_and_verify(ciphertext, tag)

	return decrypted_data.decode()

def main():
	if os.path.exists(LOG_FILE_PATH):
		os.remove(LOG_FILE_PATH)

	log_and_print("=" * 60)
	log_and_print("      HYBRID PUBLIC KEY ENCRYPTION (HPKE) SIMULATOR")
	log_and_print("=" * 60)

	bob_private, bob_public = generate_bob_recipient_keys()
	log_and_print("[*] Bob published his RSA Public Key.")

	secret_payload = "This is a large data payload encrypted efficiently via AES and protected via RSA!"
	log_and_print(f"\n[+] Data to transmit: '{secret_payload}'")

	bundle = alice_hybrid_encrypt(secret_payload, bob_public)
	recovered_plaintext = bob_hybrid_decrypt(bundle, bob_private)

	log_and_print("\n" + "=" * 60)
	log_and_print(f"[SUCCESS] Hybrid Decryption complete!")
	log_and_print(f"Final Plaintext Output: {recovered_plaintext}")
	log_and_print("=" * 60)
	print(f"\n[INFO] Execution log saved to: {LOG_FILE_PATH}")

if __name__ == "__main__":
    main()
