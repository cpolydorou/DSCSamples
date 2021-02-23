<#
    Author  : Christos Polydorou
    Date    : February 16 2021
    Purpose : DSC LCM Configuration example
    URL     : https://blog.cpolydorou.net/2021/02/configuring-virtual-machines-using_23.html
#>

[DSCLocalConfigurationManager()]
configuration LCMConfig
{
    Node localhost
    {
        Settings
        {
            RefreshMode = 'Push'
            ConfigurationMode = 'ApplyAndMonitor'
            RebootNodeIfNeeded = $true
            RefreshFrequencyMins = 30
            ConfigurationModeFrequencyMins = 15
        }
    }
}