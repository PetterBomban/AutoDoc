Remove-Module AutoDoc
Import-Module "C:\Users\admin\Documents\GitHub\AutoDoc\AutoDoc.psm1"

InModuleScope AutoDoc {
    Describe 'Get-InstalledFeatures' {
        Context 'Fail Checks' {
            It 'Should not throw' {
                { Get-InstalledFeatures -ErrorAction Stop } | Should Not Throw
            }

            It 'Should not return null or empty' {
                Get-InstalledFeatures | Should Not BeNullOrEmpty
            }
        }

        Context 'Type Checks' {
            It 'Should be [System.Array]' {
                ## The comma prevents PowerShell from unrolling the array
                ,(Get-InstalledFeatures) | Should BeOfType [System.Array]
            }
        }

        Context 'Mocks are called' {
            It 'Calls Get-WindowsFeature once' {
                Mock Get-WindowsFeature -MockWith {
                    return @(
                        [PSCustomObject]@{
                            'Display Name' = '[ ] Active Directory Certificate Services'
                            'Name' = 'AD-Certificate'
                            'Install State' = 'Available'
                        },
                        [PSCustomObject]@{
                            'Display Name' = '    [ ] Certification Authority'
                            'Name' = 'ADCS-Cert-Authority'
                            'Install State' = 'Available'
                        }
                    )
                }

                Get-InstalledFeatures 
                $CalledOnce = 1
                Assert-MockCalled -CommandName Get-WindowsFeature -Times $CalledOnce
            }
        }
    }
}
