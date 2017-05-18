function Get-ComputerData
{
    [CmdletBinding()]
    param
    (
    )

    begin
    {
        ## Import helper scripts, such as Get-CPUInfo etc.
        . .\helpers.ps1
    }

    process
    {
        $Obj = [PSCustomObject]@{
            'ComputerName'      = $Null
            'OperatingSystem'   = $Null
            'GPU'               = $Null
            'TotalMemory'       = $Null
            'CPU'               = $Null
            'IPAddresses'       = $Null
            'InstalledFeatures' = $Null
        }        

        ## Gathering information
        $Obj.ComputerName = Get-ComputerName
        $Obj.OperatingSystem = Get-OperatingSystem
        $Obj.GPU = Get-GPU
        $Obj.TotalMemory = Get-ComputerMemory
        $OBj.CPU = Get-CPUInfo
        $Obj.IPAddresses = Get-IPAddresses

        ## Get-WindowsFeature is not supported on client-OS'es
        try
        {
            $Obj.InstalledFeatures = Get-InstalledFeatures
        }
        catch
        {
            $Obj.InstalledFeatures = 'Not supported'
        }

        Write-Output $Obj
    }
}
