function Get-ComputerData {
    [CmdletBinding()]
    param
    (
        [Parameter (Mandatory = $True)]
        [ValidateSet("Client", "Server")]
        [String] $ComputerType
    )

    begin {
        ## Import helper scripts, such as Get-CPUInfo etc.
        . .\helpers.ps1
    }

    process {
        ## Misc.
        $computerName = Get-ComputerName
        $os = Get-OperatingSystem
        $gpu = Get-GPU

        ## Memory
        $memory = Get-ComputerMemory

        ## CPU Info
        $CPUInfo = Get-CPUInfo

        ## Gather ip addresses from enabled adapters
        $IPAddress = Get-IPAddresses
        
        ## Get-WindowsFeature is not supported on client-OS'es
        $installedFeatures = "N/A"
        if ($ComputerType -eq "Server") {
            $installedFeatures = Get-InstalledFeatures
        }

        $Result = [PSCustomObject]@{
            'ComputerName'      = $computerName
            'OperatingSystem'   = $os
            'GPU'               = $gpu
            'TotalMemory'       = $memory
            'CPUInfo'           = $CPUInfo
            'IPAddresses'       = $IPAddress
            'InstalledFeatures' = $installedFeatures
        }

        Write-Output $Result
    }
}
