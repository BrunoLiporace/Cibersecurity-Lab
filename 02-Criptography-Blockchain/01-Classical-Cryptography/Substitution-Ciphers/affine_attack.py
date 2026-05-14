import math

def decrypt_affine(ciphertext, a, b):
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    try:
        a_inv = pow(a, -1, 26)
    except ValueError:
        return None
    
    plaintext = ""
    for char in ciphertext.lower():
        if char in alphabet:
            y = alphabet.find(char)
            x = (a_inv * (y - b)) % 26
            plaintext += alphabet[x]
        else:
            plaintext += char
    return plaintext

# Target ciphertext from Module 1 Lab
secret = "Gdnkrauvhkdcrdxpxgsxpdkkvggvsxzqnvqwzquvsxuxnqrndpfzxaxklruxqdguxkdktlvsrcrndklxqpdwxpvdknmrevpnvqxgviwxurevsxfzxqvazxsdqpxkgxrsvpavkuvsvpdfzxggvpzpzdkrvpfzxqvxpuxqdzuvkrydsvpdmdnxkgv"

# Final solution identified via brute force
a_key, b_key = 5, 3
result = decrypt_affine(secret, a_key, b_key)

print("--- AFFINE CIPHER DECRYPTION REPORT ---")
print(f"Parameters found: a={a_key}, b={b_key}")
print(f"Decrypted Message: {result}")
