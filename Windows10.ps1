# Delete offending Reg Key
# reg delete "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\TileDataModel\Migration\TileStore" /va /f

# Fix Repo CPU Usage
# get-appxpackage -packageType bundle |% {add-appxpackage -register -disabledevelopmentmode ($_.installlocation + "\appxmetadata\appxbundlemenifest.xml")}
# $bundlefamilies = (get-appxpackage -packagetype Bundle).packagefamilyname
# get-appxpackage -packagetype main |? {-not ($bundlefamilies -contains $_.packagefamilyname)} |% {add-appxpackage -register -disabledevelopmentmode ($_.installlocation + "\appxmanifest.xml")}

# Please Run "Set-ExecutionPolicy -Scope Process Unrestricted -Force" in elevated Powersheell before running this script. 

Clear-Host
# Variables

$computername = "Bhoomi"
function RemoveNotRequiredApps {
Write-Host "Removing Not Required Metro Apps"
Write-Host "-------------------------------------------------------------------"
# Uninstall Packages

# 3D Builder
Get-AppxPackage Microsoft.3DBuilder | Remove-AppxPackage
Get-AppxPackage Microsoft.Print3D | Remove-AppxPackage
Get-AppxPackage Microsoft.Microsoft3DViewer | Remove-AppxPackage

# Email and Calender 
Get-AppxPackage microsoft.windowscommunicationsapps | Remove-AppxPackage
# Alarms
Get-AppxPackage Microsoft.WindowsAlarms | Remove-AppxPackage

# Autodesk
Get-AppxPackage *Autodesk* | Remove-AppxPackage

# Bing Weather, News, Sports, and Finance (Money):
Get-AppxPackage Microsoft.BingFinance | Remove-AppxPackage
Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage
Get-AppxPackage Microsoft.BingSports | Remove-AppxPackage
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage


# Candy Crush
Get-AppxPackage king.com.CandyCrush* | Remove-AppxPackage

# Comms Phone
Get-AppxPackage Microsoft.CommsPhone | Remove-AppxPackage

# Feedback Hub
Get-AppxPackage Microsoft.WindowsFeedbackHub | Remove-AppxPackage

# Get Started, Get Help
Get-AppxPackage Microsoft.Getstarted | Remove-AppxPackage
Get-AppxPAckage Microsoft.GetHelp | Remove-AppxPackage

# Maps
Get-AppxPackage Microsoft.WindowsMaps | Remove-AppxPackage

# March of Empires
Get-AppxPackage *MarchofEmpires* | Remove-AppxPackage

# Messaging
Get-AppxPackage Microsoft.Messaging | Remove-AppxPackage

# Minecraft
Get-AppxPackage *Minecraft* | Remove-AppxPackage

# Netflix
Get-AppxPackage *Netflix* | Remove-AppxPackage

# Office Hub
Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage

# One Connect
Get-AppxPackage Microsoft.OneConnect | Remove-AppxPackage

# OneNote
Get-AppxPackage Microsoft.Office.OneNote | Remove-AppxPackage

# People
Get-AppxPackage Microsoft.People | Remove-AppxPackage

# Phone
Get-AppxPackage Microsoft.WindowsPhone | Remove-AppxPackage


# Skype (Metro version)
Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage

# Sound Recorder
Get-AppxPackage Microsoft.WindowsSoundRecorder | Remove-AppxPackage

# Solitaire
Get-AppxPackage *Solitaire* | Remove-AppxPackage

# Weather
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage

# Weather
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage

# Sticky Notes
Get-AppxPackage Microsoft.MicrosoftStickyNotes | Remove-AppxPackage

# Sway
Get-AppxPackage Microsoft.Office.Sway | Remove-AppxPackage

# Twitter
Get-AppxPackage *Twitter* | Remove-AppxPackage

# Xbox
Get-AppxPackage Microsoft.XboxApp | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxIdentityProvider | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxGameOverlay | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxSpeechToTextOverlay  | Remove-AppxPackage
Get-AppxPackage XboxGameCallableUI | Remove-AppxPackage
Get-AppxPackage Xbox.TCUI | Remove-AppxPackage
# 1803
Get-AppxPackage Microsoft.XboxGamingOverlay | Remove-AppxPackage
Get-AppxPackage Microsoft.Wallet | Remove-AppxPackage

}


function DisableXboxGamebar {
# Disable Xbox Gamebar
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name AppCaptureEnabled -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name GameDVR_Enabled -Type DWord -Value 0
}

function TurnoffPeople {
# Turn off People in Taskbar
Write-Host "Turning off People Bar"
If (-Not (Test-Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
    New-Item -Path HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People | Out-Null
}
Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name PeopleBand -Type DWord -Value 0
}


Function DisableTelemetry {
    # Disable Windows Telemetry
	Write-Host "Disabling Telemetry..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
	Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-Null
	Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-Null
	Disable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-Null
	Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-Null
	Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-Null
	Disable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-Null

}


# Disable Wi-Fi Sense
Function DisableWiFiSense {
	Write-Host "Disabling Wi-Fi Sense..."
	If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
		New-Item -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -Type DWord -Value 0
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Type DWord -Value 0
	If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config")) {
		New-Item -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "AutoConnectAllowedOEM" -Type Dword -Value 0
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "WiFISenseAllowed" -Type Dword -Value 0
}


# Disable Web Search in Start Menu
Function DisableWebSearch {
	Write-Host "Disabling Bing Search in Start Menu..."
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0
	If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -Type DWord -Value 1
}



Function DisableAppSuggestions {
	Write-Host "Disabling Application suggestions..."
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0
	If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1
}




# Set BIOS time to UTC
Function SetBIOSTimeUTC {
	Write-Host "Setting BIOS time to UTC..."
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "RealTimeIsUniversal" -Type DWord -Value 1
}


function OtherTweaks{
# WiFi Sense: Shared HotSpot Auto-Connect: Disable
Set-ItemProperty -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots -Name value -Type DWord -Value 0

# Start Menu: Disable Bing Search Results
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Type DWord -Value 0

# Change Explorer home screen back to "This PC"
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Type DWord -Value 1

}

function RenamePC {
#--- Rename the Computer ---
# Requires restart, or add the -Restart flag
if ($env:computername -ne $computername) {
	Rename-Computer -NewName $computername
}
}



function SetupBuiltinFeatures {
    
	# Disable IE, SMD Direct, Powershell v2, Work Folders etc.
	Writ-Host "Disabling Windows Features"
    	# XPS is not included in 1803 Builds so this command will fail. Ignore it.
	Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Printing-XPSServices-Package" -NoRestart
    	Disable-WindowsOptionalFeature -Online -FeatureName "FaxServicesClientPackage" -NoRestart
    	Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-NetFx3-OC-Package" -NoRestart
    	Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Client-EmbeddedExp-Package" -NoRestart
    	Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-NetFx3-WCF-OC-Package" -NoRestart
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

	Writ-Host "Enabling Windows Features"
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

	# Careful With Enabling This Feature on Non UEFI devices.
	Enable-WindowsOptionalFeature -Online -FeatureName "Windows-Defender-ApplicationGuard" -NoRestart
	
	# Windows Defender Tweaks
	Write-Host "Enabling PUA Protection in Defender"
	Set-MpPreference -PUAProtection Enabled

}

# On Non Domain Windows Install AppIdentity Service cannot be started as its a 
# Protected service. Edit Registry or use sc.exe to make it automatic, for Applocker to function.
function EnableAppIdentityService {
   Write-Host "Enabling AppIdentity Service to Automatic"
   sc.exe config appidsvc start= auto
}


function InstallChoco {
    Write-Host "Installing Chocolaty"
	iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}



RemoveNotRequiredApps
DisableXboxGamebar
TurnoffPeople
#DisableTelemetry
DisableWiFiSense
DisableWebSearch
DisableAppSuggestions
SetBIOSTimeUTC
OtherTweaks
RenamePC
#InstallChoco
SetupBuiltinFeatures
EnableAppIdentityService

Write-Host "-------------------------------------------------------------------"
