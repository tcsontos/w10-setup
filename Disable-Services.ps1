#   Description:

# This script disables unwanted Windows services. If you do not want to disable

# certain services comment out the corresponding lines below.

function DisableServices {

$services = @(

    "diagnosticshub.standardcollector.service" # Microsoft (R) Diagnostics Hub Standard Collector Service

    "DiagTrack"                                # Diagnostics Tracking Service

    "HomeGroupListener"                        # HomeGroup Listener

    "HomeGroupProvider"                        # HomeGroup Provider

    "lfsvc"                                    # Geolocation Service

    "MapsBroker"                               # Downloaded Maps Manage

    "RemoteAccess"                             # Routing and Remote Access

    "RemoteRegistry"                           # Remote Registry

    "SharedAccess"                             # Internet Connection Sharing (ICS)

    "TrkWks"                                   # Distributed Link Tracking Client

    "WbioSrvc"                                 # Windows Biometric Service

    #"WlanSvc"                                 # WLAN AutoConfig

    "WMPNetworkSvc"                            # Windows Media Player Network Sharing Service


    #"WSearch"                                 # Windows Search

    "XblAuthManager"                           # Xbox Live Auth Manager

    "XblGameSave"                              # Xbox Live Game Save Service

    "XboxNetApiSvc"                            # Xbox Live Networking Service



    # Services which cannot be disabled

    #"WdNisSvc"

)



foreach ($service in $services) {

    Write-Output "Trying to disable $service"

    Get-Service -Name $service | Set-Service -StartupType Disabled

}

}

function DisableTasks {
Write-Output "Trying to disable Tasks"

$tasks = @(

    "\Microsoft\XblGameSave\XblGameSaveTask" # Xbox Tasks

     "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" # CEIP

     "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" # CEIP

     "\Microsoft\Windows\Feedback\Siuf\DmClient" # Feedback

     "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"

     "\Microsoft\Windows\Application Experience\ProgramDataUpdater" # Compatibility Telemetry

     "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"

)
    foreach ($task in $tasks) {

        #Write-Output "Trying to disable Task :$task"

        Disable-ScheduledTask -TaskName $task
        
    }
}

DisableServices
DisableTasks