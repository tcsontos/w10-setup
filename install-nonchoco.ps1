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
$ADBDirectory = "android-tools"
$ShortcutsDirectory = "Shortcuts"
$SysinternalDirectory = "SysInternalTools"
$Tools_Install_Directory = "C:\Tools"
$ADB_Install_Directory = "C:\Tools\android-tools"
$Sysinternal_Install_Directory = "C:\Tools\SysInternalTools"
$SysinternalShortcuts_Install_Directory = "C:\Tools\SysInternalTools"
$DockerInstaller = "Docker for Windows Installer.exe"


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
    CheckFileAndInstall $YubikeyManager "/S /v /qn" "Yubikey Manager (Beta)" 
    CheckFileAndInstall $YubikeyPIVManager "/S /v /qn" "Yubikey PIV Tool"
    CheckFileAndInstall $YubikeyPersonalizationTool "/S /v /qn" "Yubikey Personalization Tool"
    CheckFileAndInstall $YubikeyAuthenticator "/S /v /qn" "Yubico Authenticator"
    CheckFileAndInstall $GPGTool "/S /C=gpg4win.ini" "GPG4Win"    
  
}


# StartupScripts
function CopyStartupScripts {
    Write-Host "Copying Startup Scripts"


}

# Sysinternal Tools
function InstallSysInternalTools {
    Write-Host "Installing SysInternal Tools"
}

# ADB Tools 
function InstallADBTools {
Write-Host "Adding Adb Tools to System PATH"

}

# AutoMount VHDs
function SetupMountTasks {
    Write-Host "Setting UP Auto Mount VDHs in File: C:\Tools\attach_vdisk.txt"
}

# LinuxBoot
# Copy the first 512 bytes of Linux partition into a file linux.bin 
# using a live cd.
# sudo dd if=/dev/sda3 of=linux.bin bs=512 count=1
# This file must be present in C:\Linux. 
# Setup BCD to boot from this file.
# Secure boot must be disabled. This method does not work with GPT disks.
# Disable MEtro Bootloader.
function SetupLinuxBoot {
    Write-Host "Setting Up Linux Bootloader Entries"
}


function InstallDocker {
    Write-Host "Installing Docker for Windows"
    & $DockerInstaller
}



fucntion SetupBuiltinFeatures {
     # Disable IE, SMD Direct, Powershell v2, Work Folders etc.
     Disable-WindowsOptionalFeature -Online -FeatureName "Xps-Foundation-Xps-Viewer" -NoRestart
     Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Printing-XPSServices-Package" -NoRestart
     Disable-WindowsOptionalFeature -Online -FeatureName "MicrosoftWindowsPowerShellV2Root" -NoRestart
     Disable-WindowsOptionalFeature -Online -FeatureName "MicrosoftWindowsPowerShellV2" -NoRestart
     Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-NetFx-VCRedist-Package" -NoRestart
     Disable-WindowsOptionalFeature -Online -FeatureName "SmbDirect" -NoRestart
     Disable-WindowsOptionalFeature -Online -FeatureName "NetFx4-AdvSrvs" -NoRestart
     Disable-WindowsOptionalFeature -Online -FeatureName "MSRDC-Infrastructure" -NoRestart
     Disable-WindowsOptionalFeature -Online -FeatureName "NetFx4Extended-ASPNET45" -NoRestart
     Disable-WindowsOptionalFeature -Online -FeatureName "WorkFolders-Client" -NoRestart
     Disable-WindowsOptionalFeature -Online -FeatureName "MSRDC-Infrastructure" -NoRestart
     Disable-WindowsOptionalFeature -Online -FeatureName "Internet-Explorer-Optional-amd64" -NoRestart

     # Enable Features: Containers, WSL, HyperV
     Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux" -NoRestart
     Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-All" -NoRestart
     Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Hypervisor" -NoRestart
     Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Tools-All" -NoRestart
     Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Management-PowerShell" -NoRestart
     Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Management-Clients" -NoRestart
     Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Hypervisor" -NoRestart
     Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Services" -NoRestart
     Enable-WindowsOptionalFeature -Online -FeatureName "Containers" -NoRestart

     # Careful With Enabling This Feature.
     # Enable-WindowsOptionalFeature -Online -FeatureName "Windows-Defender-ApplicationGuard" -NoRestart
}

# On Non Domain Windows Install AppIdentity Service cannot be started as its a 
# Protected service. Edit Registry to make it automatic, for Applocker to function.
function EnableAppIdentityService {
}
   
# Install Non Chocolaty Apps.
# Installers Must be present in Current Folder.

Write-Host "Installing Non-Chocolatey Apps"
Write-Host "---------------------------------------------"
Write-Host "---------------------------------------------"
InstallYubikeyTools
CopyStartupScripts
InstallSysInternalTools
InstallADBTools
SetupMountTasks
SetupLinuxBoot
SetupBuiltinFeatures
EnableAppIdentityService