# Installs Tools
# This Script Requires specific Tools and installers to be present in
# Specific directories.
# Directory Tree
# ----------------------------
# ..
#  (Dir)  android-tools
#  (Dir)  Tools
#  (Dir)  SysInternalTools
#  (Dir)  Shotcuts
#  (Dir)  StartupShortcuts
#  (file) attach-vhd.txt
#  (file) automount.bat
#  --- Various Installers ------
#  
Clear-Host

# Define Installer Files as Variables.
$YubikeyPersonalizationTool = "yubikey-personalization-gui-3.1.25.exe"
$YubikeyPIVManager = "yubikey-piv-manager-1.4.2d-win.exe"
$YubikeyAuthenticator = "yubioath-desktop-4.3.3-win.exe"
$YubikeyManager = "yubikey-manager-qt-0.4.0-win.exe"
$GPGTool = "gpg4win-3.0.3.exe"

# Define Paths
$CurrentPath = [Environment]::CurrentDirectory
$Hostname = [Environment]::MachineName
$ToolsDirectory = "Tools"
$ShortcutsDirectory = "Shortcuts"
$SysinternalDirectory = "SysInternalTools"
$Tools_Install_Directory = "C:\Tools"
$ADB_Install_Directory = "C:\Tools\Android"


# Check if path exists, if not create the directory.
# Argument: 1 Full path to directory
function CheckCreateDirectory {
    Param(
    [parameter(Mandatory=$true)]
    [String]$TargetDirectory)
    if(!(Test-Path -Path $TargetDirectory ))
        {
            New-Item -ItemType directory -Path $TargetDirectory
        }
}



# Check if a File exists return true, if not return false.
# Argument: 1 Full path to the File
function CheckFileAndInstall {
    Param(
    [parameter(Mandatory=$true)]
    [String]$TargetFile)
    [String]$InstallerCommands
    [String]$ApplicationName 
    if(Test-Path -Path $TargetFile )
    {
        Write-Host "Installing" + $ApplicationName
        Write-Host "-----------------------------------------------------"
        & $TargetFile $InstallerCommands            
    }
    Else
    {
        Write-Host "Error!! Installer for" $ApplicationName + ":" + $TargetFile " Not Found."
    }
}



# Yubikey Tools & GPG
function InstallYubikeyTools {
    CheckFileAndInstall "$YubikeyManager" "/S /v /qn" "Yubikey Manager (Beta)" 
    CheckFileAndInstall "$YubikeyPIVManager" "/S /v /qn" "Yubikey PIV Tool"
    CheckFileAndInstall "$YubikeyPersonalizationTool" "/S /v /qn" "Yubikey Personalization Tool"
    CheckFileAndInstall "$YubikeyAuthenticator" "/S /v /qn" "Yubico Authenticator"   
  
}


# Yubikey Tools & GPG
function InstallYubikeyTools_OM {

    .\yubikey-personalization-gui-3.1.25.exe /S /v /qn
    .\yubikey-piv-manager-1.4.2d-win.exe /S /v /qn
    .\yubioath-desktop-4.3.3-win.exe /S /v /qn
    .\yubikey-manager-qt-0.4.0-win.exe /S /v /qn
  
}


# StartupScripts
function CopyStartupItems {
    Write-Host "Copying Shortcut Items"
    $sourceRoot = ".\Shortcuts"
    $destinationRoot = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs"
    Copy-Item -Path $sourceRoot -Filter "*.lnk" -Recurse -Destination $destinationRoot -Container

}



# LinuxBoot
# Copy the first 512 bytes of Linux partition into a file linux.bin 
# using a live cd.
# sudo dd if=/dev/sda3 of=linux.bin bs=512 count=1
# This file must be present in C:\Linux. 
# Setup BCD to boot from this file.
# Secure boot must be disabled. This method does not work with GPT disks.
# Disable Metro Bootloader.
function SetupLinuxBoot {
    Write-Host "Setting Up Linux Bootloader Entries"
}




function InstallOfficeAndVisio {
Write-Host "Installing Office 365"

# For 64 Bit
.\Office\setup.exe /configure .\Office\configuration.xml

# For 32 Bit
#.\Office\setup.exe /configure .\Office\configuration-32.xml
}

fucntion Install Anaconda {
Write-Host "Installing Anaconda"
.\Anaconda3-5.1.0-Windows-x86_64.exe /InstallationType=AllUsers /AddToPath=1 /RegisterPython=1 /S /D=""C:\Anaconda3\""

} 
# Install Non Chocolaty Apps.
# Installers Must be present in Current Folder.

Write-Host "Installing Non-Chocolatey Apps"
Write-Host "-------------------------------------------------------------------"
Write-Host "-------------------------------------------------------------------"
#--- Handled by Choco ---#
#InstallYubikeyTools
#InstallYubikeyTools_OM 
#------------------------#
InstallOfficeAndVisio
#CopyStartupItems
#SetupLinuxBoot