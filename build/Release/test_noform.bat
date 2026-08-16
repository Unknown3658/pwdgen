@echo off
setlocal enabledelayedexpansion

echo [TEST 1] --no-upper
set /a count=0
for /f "delims=" %%i in ('pwdgen.exe -l 24 -c 5 --no-upper -nd') do (
    set /a count+=1
    echo %%i
)
echo Count: %count%
echo.

echo [TEST 2] --no-digits
set /a count=0
for /f "delims=" %%i in ('pwdgen.exe -l 24 -c 5 -nu --no-digits') do (
    set /a count+=1
    echo %%i
)
echo Count: %count%
echo.

echo [TEST 3] --no-upper --no-digits
set /a count=0
for /f "delims=" %%i in ('pwdgen.exe -l 24 -c 5 --no-upper --no-digits') do (
    set /a count+=1
    echo %%i
)
echo Count: %count%
echo.

echo [TEST 4] -nu -nd (short form)
set /a count=0
for /f "delims=" %%i in ('pwdgen.exe -l 24 -c 5 -nu -nd') do (
    set /a count+=1
    echo %%i
)
echo Count: %count%
echo.

echo [TEST 5] -nu -nd (short form, first)
set /a count=0
for /f "delims=" %%i in ('pwdgen.exe -nu -nd -l 24 -c 5') do (
    set /a count+=1
    echo %%i
)
echo Count: %count%
