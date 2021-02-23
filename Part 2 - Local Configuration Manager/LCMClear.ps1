<#
    Author  : Christos Polydorou
    Date    : February 16 2021
    Purpose : DSC LCM Configuration example - Clear the LCM configuration
    URL     : https://blog.cpolydorou.net/2021/02/configuring-virtual-machines-using_23.html
#>

[DSCLocalConfigurationManager()]
configuration LCMClear
{
    Node localhost
    {
        Settings
        {
            RefreshMode = 'Push'
            ConfigurationMode = 'ApplyOnly'
            RebootNodeIfNeeded = $false
            RefreshFrequencyMins = 30
            ConfigurationModeFrequencyMins = 15
        }
    }
}