#choco config set virusScannerType Generic
#choco config set genericVirusScannerPath "\Program Files\Norton Security\Engine\version\NAVW32"
#choco config set genericVirusScannerPath "C:\Program Files\Norton Security\Engine\22.11.2.7\navw32.exe"
#choco config set genericVirusScannerArgs "[[File]]"
#choco feature enable -n virusCheck

$ChocoTmpDir = "C:\ProgramData\chocolatey\temp"
New-Item -ItemType Directory -Force -Path $ChocoTmpDir
Write-Host "Setting Temp Dir for Chocolaty to : $ChocoTmpDir"
choco config set cacheLocation $ChocoTmpDir

Write-Host "---------------------------------------------------"
Write-Host "Installing Apps"
Write-Host "7Zip"
Write-Host "---------------------------------------------------"
choco install -y -r --no-progress 7zip.install 

Write-Host "Visual Studio Code"
Write-Host "---------------------------------------------------"
choco install -y -r --no-progress visualstudiocode

Write-Host "Notepad++"
Write-Host "---------------------------------------------------"
choco install -y -r --no-progress notepadplusplus

Write-Host "VLC"
Write-Host "---------------------------------------------------"
choco install -y -r --no-progress vlc

Write-Host "Firefox"
Write-Host "---------------------------------------------------"
choco install -y -r --no-progress firefox

Write-Host "Teamviewver"
Write-Host "---------------------------------------------------"
choco install -y -r --no-progress teamviewer

Write-Host "Putty"
Write-Host "---------------------------------------------------"
choco install -y -r --no-progress putty.install 

Write-Host "WinSCP"
Write-Host "---------------------------------------------------"
choco install -y -r --no-progress winscp.install

Write-Host "Skype"
Write-Host "---------------------------------------------------"
choco install -y -r --no-progress skype

Write-Host "MikTeX"
Write-Host "---------------------------------------------------"
choco install -y -r --no-progress miktex.install

Write-Host "TeXStudio"
Write-Host "---------------------------------------------------"
choco install -y -r --no-progress texstudio

Write-Host "Pandoc"
Write-Host "---------------------------------------------------"
choco install -y -r --no-progress pandoc --ia=ALLUSERS=1

Write-Host "Git"
Write-Host "---------------------------------------------------"
choco install -y -r --no-progress git.install

Write-Host "Google Chrome"
Write-Host "---------------------------------------------------"
choco install -y -r --no-progress googlechrome

Write-Host "SysInternals"
Write-Host "---------------------------------------------------"
choco install -y -r --no-progress sysinternals  --package-parameters='/InstallDir=""C:\Tools\SysInternals""'

Write-Host "GPG4Win"
Write-Host "---------------------------------------------------"
choco install -y -r --no-progress gpg4win
#choco install -y -r --no-progress -ia '/C=""C:\Tools\w10-setup\gpg4win.ini""'

Write-Host "VcxSrv"
Write-Host "---------------------------------------------------"
choco install -y -r --no-progress vcxsrv 

Write-Host "ConEmu"
Write-Host "---------------------------------------------------" 
choco install -y -r --no-progress conemu

# Always install this after Git.
Write-Host "Git Credential Manager"
Write-Host "---------------------------------------------------" 
choco install -y -r --no-progress git-credential-manager-for-windows

Write-Host "Docker, Kubernetes and VM Tools"
Write-Host "---------------------------------------------------"
Write-Host "Docker"
choco install -y -r --no-progress docker-for-windows
 
# Disabled because Chocolaty uses shims which interfere with applocker. and no way to override Install Paths for these tools
#Write-Host "Kubernetes CLI"
#choco install -y -r --no-progress kubernetes-cli

#Write-Host "MiniKube"
#choco install -y -r --no-progress minikube

# Dont install as it should be moved into PRGFILES\Docker to open with docker UI.
#Write-Host "Docker Kitematic" 
#choco install -y -r --no-progress docker-kitematic

#Write-Host "Kubernetes Kompose" 
#choco install -y -r --no-progress kubernetes-kompose

Write-Host "Vagrant"
choco install -y -r --no-progress vagrant 

Write-Host "Cloud SDK and CLIs"
Write-Host "---------------------------------------------------"

Write-Host "Visual C++ Redistributable 2008 SP1"
# This is required by awscli on Windows 10 1803. 
# Failure to install this leads to Error below. 
# Dependent Assembly Microsoft.VC90.CRT,processorArchitecture="amd64",
# publicKeyToken="1fc8b3b9a1e18e3b",type="win32",version="9.0.21022.8" could not be found. 
# Please use sxstrace.exe for detailed diagnosis.
choco install -y -r --no-progress vcredist2008

Write-Host "AWS CLI"
choco install -y -r --no-progress awscli

Write-Host "Google Cloud SDK"
choco install -y -r --no-progress gcloudsdk

Write-Host "Cloud Storage"
Write-Host "---------------------------------------------------"
Write-Host "Dropbox"
choco install -y -r --no-progress dropbox

Write-Host "Other Tools"
Write-Host "---------------------------------------------------"
choco install -y -r --no-progress audacity 

Write-Host "Yubico Tools"
Write-Host "---------------------------------------------------"
Write-Host "Yubico Authenticator"
choco install -y -r --no-progress yubico-authenticator
Write-Host "Yubico Personalization Tool"
choco install -y -r --no-progress yubikey-personalization-tool
Write-Host "Yubikey Manager"
choco install -y -r --no-progress yubikey-manager
Write-Host "Yubikey Personalization Tool"
choco install -y -r --no-progress yubikey-piv-manager 


Write-Host "Installing Programing Languages"
Write-Host "---------------------------------------------------"
Write-Host "Changing ChocolateyToolsLocation To C:\Tools"
$Env:ChocolateyToolsLocation = "C:\Tools"
Write-Host "Installing GoLang"
choco install -y -r --no-progress golang