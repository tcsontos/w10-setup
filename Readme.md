# W-10 Setup Scripts
Scripts to Ease setting up a new Windows 10 Machine. Tested on 1803 & 1709. Some packages and features differ and you can ignore errors, if the are not available.

You need to run in Eleveted powershell & change policy to allow local powershell scripts.
```
Set-ExecutionPolicy -Scope Process Bypass -Force
```

- Windows10.ps1: Run as Admin [Installs Chocolatey as well]
- Install-choco-packages.ps1: Chocolaty packages
- Windows10-User.ps1 : Run as Standard User

[![Analytics](https://ga-beacon.prasadt.com/UA-101760811-3/github/w10-setup?flat)](https://prasadt.com/google-analytics-beacon)
