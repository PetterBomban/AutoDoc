function Get-ComputerData
{
    [CmdletBinding()]
    param
    (
    )

    begin
    {
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
        $Obj.InstalledFeatures = Get-InstalledFeatures

        Write-Output $Obj
    }
}
