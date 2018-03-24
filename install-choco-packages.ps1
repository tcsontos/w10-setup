#choco config set virusScannerType Generic
#choco config set genericVirusScannerPath "\Program Files\Norton Security\Engine\version\NAVW32"
#choco config set genericVirusScannerPath "C:\Program Files\Norton Security\Engine\22.11.2.7\navw32.exe"
#choco config set genericVirusScannerArgs "[[File]]"
#choco feature enable -n virusCheck
Write-Host "Installing Apps"
Write-Host "7Zip"
Write-Host "---------------------------------------------------"
choco install -y 7zip.install 
Write-Host "Visual Studio Code"
Write-Host "---------------------------------------------------"
choco install -y visualstudiocode
Write-Host "Notepad++"
Write-Host "---------------------------------------------------"
choco install -y notepadplusplus
Write-Host "VLC"
Write-Host "---------------------------------------------------"
choco install -y vlc
Write-Host "Firefox"
Write-Host "---------------------------------------------------"
choco install -y firefox
Write-Host "Recuva"
Write-Host "---------------------------------------------------"
choco install -y recuva
Write-Host "Teamviewver"
Write-Host "---------------------------------------------------"
choco install -y teamviewer
Write-Host "Putty"
Write-Host "---------------------------------------------------"
choco install -y putty.install 
Write-Host "WinSCP"
Write-Host "---------------------------------------------------"
choco install -y winscp.install
Write-Host "Skype"
Write-Host "---------------------------------------------------"
choco install -y skype
Write-Host "MikTeX"
Write-Host "---------------------------------------------------"
choco install -y miktex.install
Write-Host "TeXStudio"
Write-Host "---------------------------------------------------"
choco install -y texstudio
Write-Host "Pandoc"
Write-Host "---------------------------------------------------"
choco install -y pandoc
Write-Host "Git"
Write-Host "---------------------------------------------------"
choco install -y git.install

