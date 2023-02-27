# Hashes from File
$hashFile = "hashes.txt"
$blockedAppHashes = Get-Content $hashFile

# Fetch new processes
function MonitorProcessCreation {
    $query = "SELECT * FROM __InstanceCreationEvent WITHIN 2 WHERE TargetInstance ISA 'Win32_Process'"
    $watcher = New-Object Management.ManagementEventWatcher $query

    # Start Watcher
    $watcher.Start() | Out-Null
    while ($true) {
        $event = $watcher.WaitForNextEvent()

        # Check for hashes
        $newProcess = Get-Process -Id $event.TargetInstance.ProcessId
        if ($newProcess.Path -ne $null) {
            $newProcessHash = (Get-FileHash -Path $newProcess.Path).Hash
            foreach ($blockedAppHash in $blockedAppHashes) {
                if ($blockedAppHash -eq $newProcessHash) {
                    # Kill Application
                    $newProcess.Kill()

                    #Log 
                    Write-Log " "


                    # Notification
                    Show-Notification -ToastTitle "" -ImagePath ""
                    break
                }
            }
        }
    }
}

# Fire
MonitorProcessCreation
