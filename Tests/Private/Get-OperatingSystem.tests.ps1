Remove-Module AutoDoc
Import-Module "C:\Users\admin\Documents\GitHub\AutoDoc\AutoDoc.psm1"

InModuleScope AutoDoc {
    Describe 'Get-OperatingSystem' {
        Context 'Fail Checks' {
            It 'Should not throw' {
                { Get-OperatingSystem -ErrorAction Stop } | Should Not Throw
            }

            It 'Should not return null or empty' {
                Get-OperatingSystem | Should Not BeNullOrEmpty
            }
        }

        Context 'Type Checks' {
            It 'Should be [String]' {
                Get-OperatingSystem | Should BeOfType [String]
            }
        }
    }
}
