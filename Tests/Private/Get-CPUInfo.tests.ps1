Remove-Module AutoDoc
Import-Module "C:\Users\admin\Documents\GitHub\AutoDoc\AutoDoc.psm1"

InModuleScope AutoDoc {
    Describe 'Get-CPUInfo' {
        Context 'Fail Checks' {
            It 'Should not throw' {
                { Get-CPUInfo -ErrorAction Stop } | Should Not Throw
            }

            It 'Should not return null or empty' {
                Get-CPUInfo | Should Not BeNullOrEmpty
            }
        }

        Context 'Type Checks' {
            It 'Should be [PSCustomObject]' {
                Get-CPUInfo | Should BeOfType [PSCustomObject]
            }
        }
    }
}
