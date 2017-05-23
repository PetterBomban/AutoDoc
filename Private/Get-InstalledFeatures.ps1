function Get-InstalledFeatures
{
    try
    {
        $Features = Get-WindowsFeature -ErrorAction Stop
    }
    catch 
    {
        $Features = @("Not supported")
        return $Features
    }

    $InstalledFeatures = @()
    foreach ($Feature in $Features)
    {
        if ($Feature.Installed -eq $true) { $InstalledFeatures += $Feature.Name }
    }

    Write-Output $InstalledFeatures
}
