#!/bin/bash
# Dynamic Test Script for pwdgen
# Tests all flags and combinations

echo "========================================"
echo "  Dynamic Testing of pwdgen Flags"
echo "========================================"
echo ""

# Ensure we're in the right directory
cd "D:/AI/vibecoding/password_generator_C++/build/Release" || exit 1

# Test 1: Basic usage (default)
echo "[TEST 1] Basic usage (default 16 chars)"
pwdgen
echo ""

# Test 2: Help
echo "[TEST 2] Help flag (-h)"
pwdgen -h
echo ""

# Test 3: Length flag only
echo "[TEST 3] Length flag only (-l 24)"
pwdgen -l 24
echo ""

# Test 4: Count flag only
echo "[TEST 4] Count flag only (-c 5)"
pwdgen -c 5
echo ""

# Test 5: Both flags
echo "[TEST 5] Both flags (-l 30 -c 3)"
pwdgen -l 30 -c 3
echo ""

# Test 6: No lowercase
echo "[TEST 6] No lowercase (-nl)"
pwdgen -l 20 -nl
echo ""

# Test 7: No uppercase
echo "[TEST 7] No uppercase (-nu)"
pwdgen -l 20 -nu
echo ""

# Test 8: No digits
echo "[TEST 8] No digits (-nd)"
pwdgen -l 20 -nd
echo ""

# Test 9: No symbols
echo "[TEST 9] No symbols (-ns)"
pwdgen -l 20 -ns
echo ""

# Test 10: Multiple exclusions
echo "[TEST 10] Multiple exclusions (-nl -nd)"
pwdgen -l 20 -nl -nd
echo ""

# Test 11: All exclusions (should fail)
echo "[TEST 11] All exclusions (-nl -nu -nd -ns) - should fail"
pwdgen -l 20 -nl -nu -nd -ns
echo "Exit code: $?"
echo ""

# Test 12: Batch generation
echo "[TEST 12] Batch generation (-l 16 -c 10)"
pwdgen -l 16 -c 10
echo ""

# Test 13: Long password
echo "[TEST 13] Long password (-l 64)"
pwdgen -l 64
echo ""

# Test 14: Maximum length (256)
echo "[TEST 14] Maximum length (-l 256)"
pwdgen -l 256
echo ""

# Test 15: Minimum length validation (should fail)
echo "[TEST 15] Minimum length validation (-l 15) - should fail"
pwdgen -l 15
echo "Exit code: $?"
echo ""

# Test 16: Invalid length (should fail)
echo "[TEST 16] Invalid length (-l abc) - should fail"
pwdgen -l abc
echo "Exit code: $?"
echo ""

# Test 17: Negative count (should fail)
echo "[TEST 17] Negative count (-c 0) - should fail"
pwdgen -c 0
echo "Exit code: $?"
echo ""

# Test 18: Unknown flag (should fail)
echo "[TEST 18] Unknown flag (-xyz) - should fail"
pwdgen -xyz
echo "Exit code: $?"
echo ""

# Test 19: Character set with numbers only
echo "[TEST 19] Numbers only (-nu -ns)"
pwdgen -l 20 -nu -ns
echo ""

# Test 20: Character set with uppercase only
echo "[TEST 20] Uppercase only (-nl -nd -ns)"
pwdgen -l 20 -nl -nd -ns
echo ""

# Test 21: Character set with lowercase only
echo "[TEST 21] Lowercase only (-nu -nd -ns)"
pwdgen -l 20 -nu -nd -ns
echo ""

# Test 22: Pipe to file
echo "[TEST 22] Pipe to file (-l 16 -c 5 > test.txt)"
pwdgen -l 16 -c 5 > test.txt
cat test.txt
echo ""

# Test 23: Pipe to grep
echo "[TEST 23] Pipe to grep (contains @)"
pwdgen -l 30 -c 20 | grep '@'
echo ""

# Test 24: Count with exclusions
echo "[TEST 24] Count with exclusions (-l 16 -c 3 -nd)"
pwdgen -l 16 -c 3 -nd
echo ""

# Test 25: Long batch
echo "[TEST 25] Long batch (-l 32 -c 100) - first 5 passwords only"
pwdgen -l 32 -c 100 | head -5
echo ""

# Test 26: Very short valid (16 chars minimum)
echo "[TEST 26] Minimum valid length (-l 16)"
pwdgen -l 16
echo ""

# Test 27: All flags combined
echo "[TEST 27] All flags combined (-l 24 -c 3 -nu -nd -ns)"
pwdgen -l 24 -c 3 -nu -nd -ns
echo ""

# Test 28: Long password with count
echo "[TEST 28] Long password with count (-l 128 -c 2)"
pwdgen -l 128 -c 2
echo ""

echo "========================================"
echo "  All tests completed!"
echo "========================================"

# Cleanup
rm -f test.txt
