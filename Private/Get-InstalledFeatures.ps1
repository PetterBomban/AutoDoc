function Get-InstalledFeatures
{
    try
    {
        $Features = Get-WindowsFeature -ErrorAction Stop
    }
    catch 
    {
        $Features = @("Not supported")
        Write-Output $Features
        break
    }

    $InstalledFeatures = @()
    foreach ($Feature in $Features)
    {
        if ($Feature.Installed -eq $true) { $InstalledFeatures += $Feature.Name }
    }

    Write-Output $InstalledFeatures
}
