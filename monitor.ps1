Function Register-Monitor {
    param ($path)
    $filter = "*.*" #all files
    $monitor = New-Object IO.FileSystemWatcher $path, $filter -Property @{ 
        IncludeSubdirectories = $false
        EnableRaisingEvents = $true
    }
    $changeAction = [scriptblock]::Create('
        # This is the code which will be executed every time a file change is detected
        $path = $Event.SourceEventArgs.FullPath
        $name = $Event.SourceEventArgs.Name
        $changeType = $Event.SourceEventArgs.ChangeType
        $timeStamp = $Event.TimeGenerated
        Write-Host "$changeType $name at $timeStamp"
        # To send a keystroke, utilise these lines
        # $wsh = New-Object -ComObject WScript.Shell
        # $wsh.SendKeys("{NUMLOCK}")
    ')
    Register-ObjectEvent $monitor "changed" -Action $changeAction
}

 Register-Monitor "c:\Users\louisMachin\Desktop\Powershell\ps-registry-monitor\temp"