# Lab Solution: Affine Cipher Analysis

## Methodology
A brute-force attack was conducted using Python to iterate through all possible keys in the Affine keyspace ($12 \times 26 = 312$ keys).

## Results
- **Found Key:** a=5, b=3
- **Plaintext:** "la criptografia es el desarrollo de un conjunto de tecnicas que permite..."
- **Technical Note:** The script successfully handled modular inverse calculations and ignored non-alphabetic characters.

## Conclusion
The limited entropy of the Affine cipher makes it trivial to break using modern computational power. It serves as a foundational example of why larger keyspaces are required for modern security.
