# Lab Report: Enigma M3 Cryptanalysis

## Objective
Decrypt two intercepted messaes dated April 12, 1940, using the Kriegmarine M3 configuration.

## Intercepted Ciphertexts
1. `OJSBI BUPKA ECMEE ZH`
2. `REVNU XWYCV HZFSH NFMSP`

## Machine Configuration (The Key)
- **Model:** Enigma M3
- **Reflector:** UKW-B
- **Rotors:** I, II, III
- **Ring Settings:** C-K-U
- **Initial Positions:** V-N-A
- **Plugboard (Steckerbrett):** CK IZ QT NP JY GW

## Execution & Results
Using the 101computing simulator, the following plaintexts were recovered:
- **Message A:** `KRIEG SMARI NE...` (Confirmed keyword: Navy)
- **Message B:** `KEINE BESON DEREN...` (Confirmed: "Nothing to report")

## Technical Insight
The UKW-B reflector's design flaw (no letter encrypts to itself) was the primary vector used by Bletchley Park for "crib" attacks.
