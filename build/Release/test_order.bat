@echo off
echo [TEST 1] -l 24 -c 5 -nu -nd
set /a count=0
for /f "delims=" %%i in ('pwdgen.exe -l 24 -c 5 -nu -nd') do (
    set /a count+=1
    echo %%i
)
echo Count: %count%
echo.

echo [TEST 2] -l 24 -nu -nd -c 5
set /a count=0
for /f "delims=" %%i in ('pwdgen.exe -l 24 -nu -nd -c 5') do (
    set /a count+=1
    echo %%i
)
echo Count: %count%
echo.

echo [TEST 3] -c 5 -l 24 -nu -nd
set /a count=0
for /f "delims=" %%i in ('pwdgen.exe -c 5 -l 24 -nu -nd') do (
    set /a count+=1
    echo %%i
)
echo Count: %count%
echo.

echo [TEST 4] -nu -nd -l 24 -c 5
set /a count=0
for /f "delims=" %%i in ('pwdgen.exe -nu -nd -l 24 -c 5') do (
    set /a count+=1
    echo %%i
)
echo Count: %count%
echo.

echo [TEST 5] --length 24 --count 5 --no-upper --no-digits
set /a count=0
for /f "delims=" %%i in ('pwdgen.exe --length 24 --count 5 --no-upper --no-digits') do (
    set /a count+=1
    echo %%i
)
echo Count: %count%
echo.

echo [TEST 6] --length 24 --count 5 -nu -nd
set /a count=0
for /f "delims=" %%i in ('pwdgen.exe --length 24 --count 5 -nu -nd') do (
    set /a count+=1
    echo %%i
)
echo Count: %count%
echo.

echo [TEST 7] -l 24 -c 5 --no-upper -nd
set /a count=0
for /f "delims=" %%i in ('pwdgen.exe -l 24 -c 5 --no-upper -nd') do (
    set /a count+=1
    echo %%i
)
echo Count: %count%
echo.

echo [TEST 8] --length 24 -nu -nd -c 5
set /a count=0
for /f "delims=" %%i in ('pwdgen.exe --length 24 -nu -nd -c 5') do (
    set /a count+=1
    echo %%i
)
echo Count: %count%
echo.

echo [TEST 9] -c 5 -l 24 -nu -nd -ns
set /a count=0
for /f "delims=" %%i in ('pwdgen.exe -c 5 -l 24 -nu -nd -ns') do (
    set /a count+=1
    echo %%i
)
echo Count: %count%
echo.

echo [TEST 10] -ns -nd -l 24 -c 5 -nu
set /a count=0
for /f "delims=" %%i in ('pwdgen.exe -ns -nd -l 24 -c 5 -nu') do (
    set /a count+=1
    echo %%i
)
echo Count: %count%
