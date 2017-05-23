function Get-InstalledFeatures
{
    try
    {
        $Features = Get-WindowsFeature -ErrorAction Stop
    }
    catch 
    {
        $NotSupported = [PSCustomObject]@{
            'Installed' = $True
            'Name'      = 'Not supported on client OS'
        }

        $Features = @($NotSupported)
    }

    $InstalledFeatures = @()
    foreach ($Feature in $Features)
    {
        if ($Feature.Installed -eq $true) { $InstalledFeatures += $Feature.Name }
    }

    Write-Output [Array]($InstalledFeatures)
}
