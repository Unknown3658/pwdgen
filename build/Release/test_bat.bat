@echo off
echo [TEST 1: -l 24 -c 5]
pwdgen.exe -l 24 -c 5 > test1.txt
echo Output lines: %errorlevel%
type test1.txt
del test1.txt


echo [TEST 2: -l 16 -c 3]
pwdgen.exe -l 16 -c 3 > test2.txt
echo Output lines: %errorlevel%
type test2.txt
del test2.txt


echo [TEST 3: -l 32 -c 10 -nu -nd]
pwdgen.exe -l 32 -c 10 -nu -nd > test3.txt
echo Output lines: %errorlevel%
type test3.txt
del test3.txt


echo [TEST 4: -l 256 -c 100]
pwdgen.exe -l 256 -c 100 > test4.txt
echo Output lines: %errorlevel%
type test4.txt
del test4.txt

echo [TEST 5: -l 15 -c 5] (should fail)
pwdgen.exe -l 15 -c 5
echo Exit code: %errorlevel%


echo [TEST 6: -l abc -c 5] (should fail)
pwdgen.exe -l abc -c 5
echo Exit code: %errorlevel%

echo [TEST 7: -l 24 -c 0] (should fail)
pwdgen.exe -l 24 -c 0
echo Exit code: %errorlevel%

echo [TEST 8: -l 24 -c abc] (should fail)
pwdgen.exe -l 24 -c abc
echo Exit code: %errorlevel%
