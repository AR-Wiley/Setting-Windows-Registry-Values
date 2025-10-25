function Set-TeamsAddinRegistryValues {

    $path = @{
        AddinsPath = "HKCU:Software\Microsoft\Office\Outlook\Addins\TeamsAddin.FastConnect"
        AddinsDataPath = "HKCU:Software\Microsoft\Office\Outlook\AddinsData\TeamsAddin.FastConnect"
    }

    foreach ($path in $paths.Values) {
        if (!(Test-Path -Path $path)) {
            Write-Host "Path does not exist: $path"
        }
    }
 
    $AddinsConfigs = @{
        Description = "Microsoft Teams Meeting Add-in for Microsoft Office"
        FriendlyName = "Microsoft Teams Meeting Add-in for Microsoft Office"
        LoadBehavior = 3
     }

    foreach ($key in $AddinsConfigs.Keys) {
        try {
            Set-ItemProperty -Path $AddinsPath -Name $key -Value $AddinsConfigs[$key] -Force
            Write-Host "Set $key = $($AddinsConfigs[$key])"
        } catch {
            Write-Warning "Failed to set $key : $_"
        }
    }
 
    Set-ItemProperty -Path $AddinsPath -Name LoadCount -Value 75 -Force 

}