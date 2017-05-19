Remove-Module AutoDoc
Import-Module "C:\Users\admin\Documents\GitHub\AutoDoc\AutoDoc.psm1"

InModuleScope AutoDoc {
    Describe 'Get-CPUInfo' {
        Context 'Fail Checks' {
            It 'Should not throw' {
                { Get-ComputerMemory -ErrorAction Stop } | Should Not Throw
            }

            It 'Should not return null or empty' {
                Get-ComputerMemory | Should Not BeNullOrEmpty
            }
        }

        Context 'Type Checks' {
            It 'Should be [System.Object]' {
                Get-CPUInfo | Should BeOfType [System.Object]
            }
        }
    }
}
