@echo off
cls
title Static IP Address - Chibi ANUBIS
color f0
setLocal enableDelayedExpansion
set c=0
set "choices="
echo Your Interfaces -

::=================IP ADRESS=================
SET "IP_ADDRESS=10.138.XXX.XXX"
SET "SUBNET_MASK=255.255.255.0"
SET "GATEWAY=10.138.XXX.254"
::================DNS ADRESS=================
SET "DNS_SERVER=10.138.91.252"
SET "DNS_SERVER_2=10.253.55.188"
::===========================================


for /f "skip=2 tokens=3*" %%A in ('netsh interface show interface') do (
    set /a c+=1
    call :ResolveChar !c!
    set int!retval!=%%B
    set choices=!choices!!retval!
    echo [!retval!] %%B
)

choice /c !choices! /m "Select The Number of Your Interface Please: " /n

CALL :ResolveChar %errorlevel%
SET interface=!int%retval%!
SET YOUR_INTERFACE_NAME="%interface%"
ECHO.
ECHO You have selected %YOUR_INTERFACE_NAME%.
ECHO.

:: Remove :: if needed after this line.
:: netsh interface ip set address name=%YOUR_INTERFACE_NAME% static %IP_ADDRESS% %SUBNET_MASK% %GATEWAY% 1>NUL & echo Set static IP adress %IP_ADDRESS%.
:: netsh interface ip set dns name=%YOUR_INTERFACE_NAME% static %DNS_SERVER% 1>NUL & echo Set static DNS server %DNS_SERVER%.
:: netsh interface ip add dns name=%YOUR_INTERFACE_NAME% %DNS_SERVER_2% index=2 1>NUL & echo Set static secondary DNS server %DNS_SERVER_2%.

echo.
echo Done ^^!
echo Press any keys for exit.
pause>nul
exit

:ResolveChar
SETLOCAL
  set keys=_ABCDEFGHIJKLMNOPQRSTUVWXYZ
  set _startchar=%1
  CALL SET char=%%keys:~%_startchar%,1%%
ENDLOCAL & SET retval=%char%
goto :eof

