#!/usr/bin/env python3
import os
from collections import Counter

LOG_DIR = "logs"
os.makedirs(LOG_DIR, exist_ok=True)
LOG_FILE_PATH = os.path.join(LOG_DIR, "frequency_analysis.log")

def log_and_print(message):
	print(message)
	with open(LOG_FILE_PATH, "a", encoding="utf-8") as log_file:
		log_file.write(message + "\n")

def analyze_frequencies(text):
	clean_text = [char.upper() for char in text if char.isalpha()]
	total_chars = len(clean_text)

	counts = Counter(clean_text)

	frequencies = {char: (count / total_chars) * 100 for char, count in counts.items()}

	return sorted(frequencies.items(), key=lambda x: x[1], reverse=True)

def main():
	if os.path.exists(LOG_FILE_PATH):
		os.remove(LOG_FILE_PATH)

	log_and_print("=" * 60)
	log_and_print("          STATISTICAL FREQUENCY ANALYSIS LAB")
	log_and_print("=" * 60)

	log_and_print("[*] Target Language Baseline (English Top Frequencies): E, T, A, O, I\n")

	intercepted_ciphertext = (
        "RIJ COOKI RE RIYI PYGCOYGHNENY, REO PYGCOYGHNENY NY REO SGR BH "
        "OCHBERNYV REO TOYVBHVO BENYON, REO VOZOGBH CNCO BH PYGCOYCNYROZ"
	)

	log_and_print(f"[+] Intercepted Ciphertext Packets:\n    \"{intercepted_ciphertext}\"\n")
	log_and_print("[*] Running Cryptanalysis Mathematical Model...")

	sorted_freqs = analyze_frequencies(intercepted_ciphertext)

	log_and_print("\n[+] Extracted Frequency Distribution Table:")
	log_and_print("-" * 40)
	log_and_print(f"  Character  |  Frequency Percentage")
	log_and_print("-" * 40)

	for char, percentage in sorted_freqs[:8]:  # Show top 8 leaked patterns
		log_and_print(f"      {char}      |        {percentage:.2f}%")
	log_and_print("-" * 40)

	top_leaked_char = sorted_freqs[0][0]
	log_and_print(f"\n[DEDUCTION] The character '{top_leaked_char}' has the highest density.")
	log_and_print(f"In standard English text, this character likely maps to the letter 'E' or 'T'.")

	log_and_print("=" * 60)
	print(f"\n[INFO] Local log saved to: {LOG_FILE_PATH}")

if __name__ == "__main__":
	main()
