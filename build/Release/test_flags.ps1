# Dynamic Test Script for pwdgen
# Tests all flags and combinations

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Dynamic Testing of pwdgen Flags" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Ensure we're in the right directory
Set-Location "D:/AI/vibecoding/password_generator_C++/build/Release"

# Test 1: Basic usage (default)
Write-Host "[TEST 1] Basic usage (default 16 chars)" -ForegroundColor Yellow
pwdgen
Write-Host ""

# Test 2: Help
Write-Host "[TEST 2] Help flag (-h)" -ForegroundColor Yellow
pwdgen -h | Select-Object -First 10
Write-Host ""

# Test 3: Length flag only
Write-Host "[TEST 3] Length flag only (-l 24)" -ForegroundColor Yellow
pwdgen -l 24
Write-Host ""

# Test 4: Count flag only
Write-Host "[TEST 4] Count flag only (-c 5)" -ForegroundColor Yellow
pwdgen -c 5
Write-Host ""

# Test 5: Both flags
Write-Host "[TEST 5] Both flags (-l 30 -c 3)" -ForegroundColor Yellow
pwdgen -l 30 -c 3
Write-Host ""

# Test 6: No lowercase
Write-Host "[TEST 6] No lowercase (-nl)" -ForegroundColor Yellow
pwdgen -l 20 -nl
Write-Host ""

# Test 7: No uppercase
Write-Host "[TEST 7] No uppercase (-nu)" -ForegroundColor Yellow
pwdgen -l 20 -nu
Write-Host ""

# Test 8: No digits
Write-Host "[TEST 8] No digits (-nd)" -ForegroundColor Yellow
pwdgen -l 20 -nd
Write-Host ""

# Test 9: No symbols
Write-Host "[TEST 9] No symbols (-ns)" -ForegroundColor Yellow
pwdgen -l 20 -ns
Write-Host ""

# Test 10: Multiple exclusions
Write-Host "[TEST 10] Multiple exclusions (-nl -nd)" -ForegroundColor Yellow
pwdgen -l 20 -nl -nd
Write-Host ""

# Test 11: All exclusions (should fail)
Write-Host "[TEST 11] All exclusions (-nl -nu -nd -ns) - should fail" -ForegroundColor Yellow
$result = pwdgen -l 20 -nl -nu -nd -ns 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "  Expected error occurred: OK" -ForegroundColor Green
} else {
    Write-Host "  ERROR: Should have failed but didn't" -ForegroundColor Red
}
Write-Host ""

# Test 12: Batch generation
Write-Host "[TEST 12] Batch generation (-l 16 -c 10)" -ForegroundColor Yellow
pwdgen -l 16 -c 10
Write-Host ""

# Test 13: Long password
Write-Host "[TEST 13] Long password (-l 64)" -ForegroundColor Yellow
pwdgen -l 64
Write-Host ""

# Test 14: Maximum length (256)
Write-Host "[TEST 14] Maximum length (-l 256)" -ForegroundColor Yellow
pwdgen -l 256
Write-Host ""

# Test 15: Minimum length validation (should fail)
Write-Host "[TEST 15] Minimum length validation (-l 15) - should fail" -ForegroundColor Yellow
$result = pwdgen -l 15 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "  Expected error occurred: OK" -ForegroundColor Green
} else {
    Write-Host "  ERROR: Should have failed but didn't" -ForegroundColor Red
}
Write-Host ""

# Test 16: Invalid length (should fail)
Write-Host "[TEST 16] Invalid length (-l abc) - should fail" -ForegroundColor Yellow
$result = pwdgen -l abc 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "  Expected error occurred: OK" -ForegroundColor Green
} else {
    Write-Host "  ERROR: Should have failed but didn't" -ForegroundColor Red
}
Write-Host ""

# Test 17: Negative count (should fail)
Write-Host "[TEST 17] Negative count (-c 0) - should fail" -ForegroundColor Yellow
$result = pwdgen -c 0 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "  Expected error occurred: OK" -ForegroundColor Green
} else {
    Write-Host "  ERROR: Should have failed but didn't" -ForegroundColor Red
}
Write-Host ""

# Test 18: Unknown flag (should fail)
Write-Host "[TEST 18] Unknown flag (-xyz) - should fail" -ForegroundColor Yellow
$result = pwdgen -xyz 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "  Expected error occurred: OK" -ForegroundColor Green
} else {
    Write-Host "  ERROR: Should have failed but didn't" -ForegroundColor Red
}
Write-Host ""

# Test 19: Character set with numbers only
Write-Host "[TEST 19] Numbers only (-nu -ns)" -ForegroundColor Yellow
pwdgen -l 20 -nu -ns
Write-Host ""

# Test 20: Character set with uppercase only
Write-Host "[TEST 20] Uppercase only (-nl -nd -ns)" -ForegroundColor Yellow
pwdgen -l 20 -nl -nd -ns
Write-Host ""

# Test 21: Character set with lowercase only
Write-Host "[TEST 21] Lowercase only (-nu -nd -ns)" -ForegroundColor Yellow
pwdgen -l 20 -nu -nd -ns
Write-Host ""

# Test 22: Pipe to file
Write-Host "[TEST 22] Pipe to file (-l 16 -c 5 > test.txt)" -ForegroundColor Yellow
pwdgen -l 16 -c 5 > test.txt
Write-Host "  File contents:"
Get-Content test.txt
Write-Host ""

# Test 23: Pipe to grep
Write-Host "[TEST 23] Pipe to grep (contains @)" -ForegroundColor Yellow
pwdgen -l 30 -c 20 | Select-String -Pattern '@'
Write-Host ""

# Test 24: Count with exclusions
Write-Host "[TEST 24] Count with exclusions (-l 16 -c 3 -nd)" -ForegroundColor Yellow
pwdgen -l 16 -c 3 -nd
Write-Host ""

# Test 25: Long batch
Write-Host "[TEST 25] Long batch (-l 32 -c 100) - first 5 passwords only" -ForegroundColor Yellow
pwdgen -l 32 -c 100 | Select-Object -First 5
Write-Host ""

# Test 26: Very short valid (16 chars minimum)
Write-Host "[TEST 26] Minimum valid length (-l 16)" -ForegroundColor Yellow
pwdgen -l 16
Write-Host ""

# Test 27: All flags combined
Write-Host "[TEST 27] All flags combined (-l 24 -c 3 -nu -nd -ns)" -ForegroundColor Yellow
pwdgen -l 24 -c 3 -nu -nd -ns
Write-Host ""

# Test 28: Long password with count
Write-Host "[TEST 28] Long password with count (-l 128 -c 2)" -ForegroundColor Yellow
pwdgen -l 128 -c 2
Write-Host ""

echo "========================================"
echo "  All tests completed!"
echo "========================================"

# Cleanup
if (Test-Path test.txt) {
    Remove-Item test.txt -Force
    Write-Host "  Cleanup: test.txt removed" -ForegroundColor Green
}
