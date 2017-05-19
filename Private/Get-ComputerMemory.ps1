function Get-ComputerMemory
{
    [CmdletBinding()]

    $Memory = [PSCustomObject]@{
        'TotalCapacity' = [UInt64]0
        'TotalSlots' = [Int]0
    }

    foreach ($stick in ((Get-CimInstance CIM_PhysicalMemory).Capacity))
    {
        $Memory.TotalCapacity += $stick
        $Memory.TotalSlots += 1
    }

    Write-Output $Memory
}
