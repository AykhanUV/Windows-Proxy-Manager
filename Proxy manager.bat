@echo off
:menu
cls
echo Windows Proxy Manager
echo ---------------------
echo 1. Set Proxy
echo 2. Remove Proxy
echo.

choice /C 12 /N /M "Select option (1-2): "

if errorlevel 2 goto removeproxy
if errorlevel 1 goto setproxy

:setproxy
echo.
set /p proxystring="Enter proxy address (format - ip:port): "

for /f "tokens=1,2 delims=:" %%a in ("%proxystring%") do (
    set proxyip=%%a
    set proxyport=%%b
)

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "%proxystring%" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f

echo.
echo Proxy has been set to %proxystring%
timeout /t 3
goto menu

:removeproxy
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /f

echo.
echo Proxy settings have been removed
timeout /t 3
goto menu