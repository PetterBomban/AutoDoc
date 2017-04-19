function Get-ComputerData
{
    [CmdletBinding()]
    param
    (
        [Parameter (Mandatory = $True,
                    ValueFromPipeline = $True,
                    ValueFromPipelineByPropertyName = $True)]
        [Alias("cn", "computer")]
        $ComputerName,

        [Parameter (Mandatory = $True)]
        [PSCredential] $Credential,

        [Parameter (Mandatory = $True)]
        [ValidateSet("Client", "Server")]
        [string] $ComputerType
    )

    process
    {
        $sb = {
            param ($ComputerType)

            $computerName = $Env:COMPUTERNAME
            $os = (Get-CimInstance Win32_OperatingSystem).Caption
            $gpu = (Get-CimInstance CIM_VideoController).Caption

            ## Memory
            $memory = 0
            foreach ($stick in ((Get-CimInstance CIM_PhysicalMemory).Capacity))
            {
                $memory += $stick
            }

            ## CPU Info
            $cpuNum = 0
            $cpuCores = 0
            $cpuMHz = 0
            $cpuName = ''
            foreach ($cpu in (Get-CimInstance CIM_Processor))
            {
                $cpuNum++
                $cpuCores += $cpu.NumberOfCores
                $cpuMHz = $cpu.CurrentClockSpeed
                $cpuName = $cpu.Name
            }

            ## Gather ip addresses from enabled adapters
            $IPAddress = @()
            foreach ($nic in Get-Netadapter)
            {
                ## Skip disabled adapters
                if ($nic.Status -eq "Disabled") { continue }

                foreach ($ipAddr in Get-NetIPAddress)
                {
                    if ($ipAddr.InterfaceIndex -eq $nic.ifIndex)
                    {
                        $IPAddress += $ipAddr.IPAddress
                    }
                }
            }
            
            ## Get-WindowsFeature is not supported on client-OS'es
            $installedFeatures = "N/A"
            if ($ComputerType -eq "Server")
            {
                $installedFeatures = @()
                $features = Get-WindowsFeature
                foreach ($feature in $features)
                {
                    if ($feature.Installed -eq $true) { $installedFeatures += $feature.Name }
                }
            }

            $result = [PSCustomObject]@{
                'ComputerName'      = $computerName
                'IPAddress'         = $ipAddress
                'OperatingSystem'   = $os
                'Features'          = $installedFeatures
                'CPU Name'          = $cpuName
                'CPU Sockets'       = $cpuNum
                'CPU Clock Speed'   = $cpuMHz
                'CPU Cores'         = $cpuCores
                'GPU Name'          = $gpu
                'MemoryGB'          = $memory / 1GB
            }
            Write-Output $result
        }

        $output = Invoke-Command -ComputerName $ComputerName -Credential $Credential -ScriptBlock $sb -ArgumentList $ComputerType
        $output
    }
}

## Usage example
<#
if (!($Credential))
{
    $Credential = Get-Credential
}

$out = @('Mouse.ikt-fag.no', 'sentinel.ikt-fag.no') | Get-ComputerData -ComputerType 'Server' -Credential $Credential
$out
#>
