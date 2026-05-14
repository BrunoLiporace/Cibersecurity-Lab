# Module 01: Classical Cryptography & Foundations

## Introduction
This module covers the historical evolution of cryptography, from ancient methods to the complex mechanical systems of WWII. The focus is on understanding the core principles of information security and the mathematical basis of substitution and transposition ciphers.

## Core Concepts (Learning Objectives)
- **Cryptography vs. Cryptanalysis:** Studying the balance between hiding information and the techniques used to uncover it.
- **Steganography:** Analyzing methods to hide the existence of a message itself (e.g., Demarato's wax tablets).
- **Security Pillars:**
    - **Confidentiality:** Ensuring only authorized entities access the data.
    - **Integrity:** Guaranteeing data has not been altered.
    - **Authentication:** Verifying the identity of the sender.
    - **Non-repudiation:** Ensuring the sender cannot deny the message origin.

## Technical Framework: Kerckhoffs's Principle (1883)
Following the material studied, I am implementing the principle that "The security of a cryptosystem must not depend on the secrecy of the algorithm, but only on the secrecy of the key (K)."

## Ciphers & Laboratories
### 1. Substitution Ciphers
- **Monoalphabetic:** Caesar, Atbash, and Polybius Square.
- **Affine Cipher:** Implementation of modular arithmetic $E(x) = (ax + b) \pmod{26}$.
- **Polyalphabetic:** Vigenère Cipher (1586) and the use of the *Tabula Recta*.

### 2. Transposition Ciphers
- **Scytale:** Ancient Spartan military encryption focusing on character permutation.

### 3. Mechanical Era: Enigma Machine (M3/M4)
Research and simulation of the Kriegsmarine Enigma:
- **Reflector (UKW-B):** Understanding the design flaw where a letter cannot be encrypted as itself.
- **Rotors & Plugboard:** Analyzing the exponential increase in complexity provided by the *Steckerbrett*.

## Toolset Used
- **Language:** Python 3.x (for brute-force attacks).
- **Analysis:** Frequency analysis based on language statistics (e.g., 'E' frequency in Spanish vs. English).
- **Emulators:** 101computing Enigma Simulator.
