# ys-sec - Yolish v2.29 / Windows

Port scanning has been fixed using the Windows `Test-NetConnection` result.

## Test

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
ys ys-sec.y
.\bin\ys-sec.ps1 portscan 127.0.0.1 134 135 -Service
```

Expected on the tested machine:

```text
OPEN  135  msrpc
```

Port 134 should not appear.

JSON:

```powershell
.\bin\ys-sec.ps1 portscan 127.0.0.1 134 135 -Service -Json
```

The scanner is intended for systems you own or are authorized to test.


## Verified Windows port scanner

The scanner uses `Test-NetConnection -InformationLevel Quiet` and treats output beginning with `True` as an open TCP port.

Example:

```powershell
.\bin\ys-sec.ps1 portscan 127.0.0.1 134 135 -Service
```

On a host where TCP 135 is listening and 134 is closed, the expected result is:

```text
OPEN  135  msrpc
```
