Remove-Module AutoDoc
Import-Module "C:\Users\admin\Documents\GitHub\AutoDoc\AutoDoc.psm1"

InModuleScope AutoDoc {
    Describe 'Get-ComputerName' {
        Context 'Fail Checks' {
            It 'Should not throw' {
                { Get-GPU -ErrorAction Stop } | Should Not Throw
            }

            It 'Should not return null or empty' {
                Get-GPU | Should Not BeNullOrEmpty
            }
        }
        
        Context 'Type Checks' {
            It 'Should be [String]' {
                Get-GPU | Should BeOfType [String]
            }
        }
    }
}
