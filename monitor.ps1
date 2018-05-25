Function Register-Monitor {
    param ($path)
    $filter = "*.*" #all files
    $monitor = New-Object IO.FileSystemWatcher $path, $filter -Property @{ 
        IncludeSubdirectories = $false
        EnableRaisingEvents = $true
    }
    $changeAction = [scriptblock]::Create('
        # Executed on file change
        $path = $Event.SourceEventArgs.FullPath
        $name = $Event.SourceEventArgs.Name
        $changeType = $Event.SourceEventArgs.ChangeType
        $timeStamp = $Event.TimeGenerated
        $text = Get-Content -Path $path -totalcount 1

        # Write-Host $text -foregroundcolor "magenta"
        # Write-Host "$changeType $path at $timeStamp" 
        Move-Item -path $path -destination "C:\Users\Louis\Documents\Sandbox\B"
        # Write-Host $text -foregroundcolor "magenta"

        # To send a keystroke, utilise these lines
        # $wsh = New-Object -ComObject WScript.Shell
        # $wsh.SendKeys("{NUMLOCK}")
    ')
    Register-ObjectEvent $monitor "changed" -Action $changeAction
}

 Register-Monitor "C:\Users\Louis\Documents\Sandbox\A"
