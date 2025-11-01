function Always-DownloadPDFFiles {

    if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
         Write-Host 'Not running as admin'
        return
    } else {
        Write-Host 'Running as admin'
    } 
    
    $RegistryPath = "HKCU:\Software\Policies\Microsoft\Edge"

    if (!(Test-Path -Path $RegistryPath)) {
         Write-Host "$RegistryPath does not exist"
         return
    }

    Try {
        New-ItemProperty -Path $RegistryPath -Name "AlwaysOpenPdfExternally" -Value 1 -PropertyType DWORD
        Write-Host "Registry Updated"
    } Catch {
        Write-Host "Failed to update registry"
        return
    }
} 
