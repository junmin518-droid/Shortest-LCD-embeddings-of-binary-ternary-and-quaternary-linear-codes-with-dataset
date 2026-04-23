# README

This directory contains data files and Magma scripts related to shortest LCD embeddings obtained from several seed codes.

## Contents

### 1. `R_3(1, 3).txt`
This file records the complete classification result for shortest LCD embeddings obtained from the ternary first-order Reed–Muller code `R_3(1,3)`.

### 2. `many_shortest_lcd_bklc_representatives.txt`
This file contains representative generator matrices and basic invariants for many inequivalent shortest LCD embeddings obtained from ternary BKLC seed codes.

The current uploaded data file contains the following two cases:

- `BKLC [19,4,12]  ->  [23,4,13]`
- `BKLC [19,5,11]  ->  [23,5,12]`

From the current file, the number of stored inequivalent representatives is:

- `226` codes with parameters `[23,4,13]`
- `38` codes with parameters `[23,5,12]`

### 3. `many_shortest_lcd_hamming_representatives.txt`
This file contains representative generator matrices and basic invariants for many inequivalent shortest LCD embeddings obtained from Hamming codes.

The current uploaded data file contains the following four cases:

- Binary Hamming `H_4  ->  [19,11,4]`
- Binary Hamming `H_5  ->  [36,26,4]`
- Ternary Hamming `H_3 ->  [16,10,4]`
- Ternary Hamming `H_4 ->  [44,36,4]`

From the current file, the number of stored inequivalent representatives is:

- `3778` codes with parameters `[19,11,4]`
- `841` codes with parameters `[36,26,4]`
- `3665` codes with parameters `[16,10,4]`
- `878` codes with parameters `[44,36,4]`

### 4. `verify_many_shortest_lcd_bklc_representatives.m`
This Magma script is intended to verify that the codes listed in `many_shortest_lcd_bklc_representatives.txt` are pairwise inequivalent.

Its basic workflow is:
1. read the representative file,
2. parse `REP_ID`, field size, signature, and generator matrices,
3. construct each code,
4. group representatives by signature,
5. compare codes in each bucket using `IsEquivalent`,
6. stop immediately if an equivalent pair is found,
7. otherwise print that all representatives are pairwise inequivalent.

### 5. `verify_many_shortest_lcd_hamming_representatives.m`
This Magma script verifies that the codes listed in `many_shortest_lcd_hamming_representatives.txt` are pairwise inequivalent.

Its basic workflow is:
1. read the representative file,
2. parse `REP_ID`, field size, signature, and generator matrices,
3. construct each code,
4. group representatives by signature,
5. compare codes in each bucket using `IsEquivalent`,
6. stop immediately if an equivalent pair is found,
7. otherwise print that all representatives are pairwise inequivalent.

### 6. `summary*`
The summary files are intended to provide a compact count of the number of inequivalent codes found in each case. In particular, they summarize the totals corresponding to the representative files above.

## How to run the verification scripts in Magma

Place the representative file and the corresponding verification script in the same folder, then run the script in Magma.