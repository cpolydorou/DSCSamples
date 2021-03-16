<#
    Author  : Christos Polydorou
    Date    : March 10 2021
    Purpose : DSC Configuration example
    URL     : https://blog.cpolydorou.net/2021/03/configuring-virtual-machines-using_16.html
#>

[DSCLocalConfigurationManager()]
configuration DSCClient
{
    param
    (
        [ValidateNotNullOrEmpty()]
        [string] $NodeName = 'localhost', # The name of the computer to configure

        [ValidateNotNullOrEmpty()]
        [string] $RegistrationKey         # The key to use when registering to the pull service
    )

    Node $NodeName {
        Settings{
            RefreshMode        = 'Pull'   # The mode is set to "Pull" since we want the LCM to get the configuration from the pull service
        }

        ConfigurationRepositoryWeb LAB-DSC {
            ServerURL          = "https://dsc.lab.local:443/PSDSCPullServer.svc"  # The URL of the configuration repository. Update with your host name and port. The protocol should be HTTPS
            RegistrationKey    = $RegistrationKey
            ConfigurationNames = @('WebApp001')                                   # The name of the configuration on the pull service
        }

        ReportServerWeb LAB-DSC {
            ServerURL       = "https://dsc.lab.local:443/PSDSCPullServer.svc"     # The URL of the reporting server. Update with your host name and port. The protocol should be HTTPS
            RegistrationKey = $RegistrationKey
        }
    }
}