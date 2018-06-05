# Delete offending Reg Key
# reg delete "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\TileDataModel\Migration\TileStore" /va /f

# Fix Repo CPU Usage
# get-appxpackage -packageType bundle |% {add-appxpackage -register -disabledevelopmentmode ($_.installlocation + "\appxmetadata\appxbundlemenifest.xml")}
# $bundlefamilies = (get-appxpackage -packagetype Bundle).packagefamilyname
# get-appxpackage -packagetype main |? {-not ($bundlefamilies -contains $_.packagefamilyname)} |% {add-appxpackage -register -disabledevelopmentmode ($_.installlocation + "\appxmanifest.xml")}

Clear-Host
# Variables


function RemoveNotRequiredApps {
Write-Host "Removing Not Required Metro Apps"
Write-Host "---------------------------------------------------"
# Uninstall Packages

# 3D Builder
Get-AppxPackage Microsoft.3DBuilder | Remove-AppxPackage
Get-AppxPackage Microsoft.Print3D | Remove-AppxPackage
Get-AppxPackage Microsoft.Microsoft3DViewer | Remove-AppxPackage


# Autodesk
Get-AppxPackage *Autodesk* | Remove-AppxPackage

# Bing Weather, News, Sports, and Finance (Money):
Get-AppxPackage Microsoft.BingFinance | Remove-AppxPackage
Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage
Get-AppxPackage Microsoft.BingSports | Remove-AppxPackage

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

# Photos
Get-AppxPackage Microsoft.Windows.Photos | Remove-AppxPackage

# Skype (Metro version)
Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage

# Sound Recorder
Get-AppxPackage Microsoft.WindowsSoundRecorder | Remove-AppxPackage

# Solitaire
Get-AppxPackage *Solitaire* | Remove-AppxPackage


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

}

RemoveNotRequiredApps
