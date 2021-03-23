<#
    Author  : Christos Polydorou
    Date    : March  19 2021
    Purpose : DSC Configuration example to configure LCM to use a Pull Service.
    URL     : https://blog.cpolydorou.net/2021/03/configuring-virtual-machines-using_23.html
#>

[DSCLocalConfigurationManager()]
configuration DSCClient
{
    param
    (
        [ValidateNotNullOrEmpty()]
        [string] $NodeName = 'localhost',

        [ValidateNotNullOrEmpty()]
        [string] $RegistrationKey
    )

    Node $NodeName {
        Settings{
            RefreshMode        = 'Pull'
        }

        ConfigurationRepositoryWeb LAB-DSC {
            ServerURL          = "https://dsc.lab.local:443/PSDSCPullServer.svc"
            RegistrationKey    = $RegistrationKey
            ConfigurationNames = @('WebApp001')
        }

        ReportServerWeb LAB-DSC {
            ServerURL       = "https://dsc.lab.local:443/PSDSCPullServer.svc"
            RegistrationKey = $RegistrationKey
        }
    }
}