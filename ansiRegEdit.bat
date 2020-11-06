@echo off
setlocal

echo.
echo Setting registry key for using PowerShell ANSI color codes...

reg query HKEY_CURRENT_USER\Console /v VirtualTerminalLevel 2>nul

REM if the registry already exists, verify it is set to 0x1
if %ERRORLEVEL% equ 0 goto Verify

REM else, create it
if %ERRORLEVEL% equ 1 goto Create

:Verify
for /F "skip=2 tokens=3" %%A in ('reg query HKEY_CURRENT_USER\Console /v VirtualTerminalLevel') do set "VAL=%%A"
echo.
REM if the value is what is needed already, we're done
if %VAL% equ 0x1 goto NoOp
REM else, :Create will modify it

:Create
if %ERRORLEVEL% equ 0 echo Updated key to have value of 0x1.
if %ERRORLEVEL% equ 1 echo Added key with value of 0x1.
reg add HKEY_CURRENT_USER\Console /v VirtualTerminalLevel /t REG_DWORD /d 1 /f
goto:Done

:NoOp
echo No changes made; registry key already exists with correct value.

:Done
echo Done!
pause