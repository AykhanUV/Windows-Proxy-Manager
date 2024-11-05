@echo off
title Windows Proxy Manager
:menu
cls
echo Windows Proxy Manager
echo --------------
echo 1. Set Proxy
echo 2. Remove Proxy
choice /c 12 /n /m "Enter your choice (1 or 2): "

if errorlevel 2 goto remove
if errorlevel 1 goto set

:set
set /p proxy=Enter proxy (ip:port): 
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d %proxy% /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f >nul
echo Proxy set successfully.
goto end

:remove
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f >nul
echo Proxy removed successfully.
goto end

:end
timeout /t 5
goto menu
