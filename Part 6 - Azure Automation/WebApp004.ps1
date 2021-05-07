<#
    Author  : Christos Polydorou
    Date    : May 5 2021
    Purpose : DSC Configuration example
    URL     : https://blog.cpolydorou.net/2021/05/configuring-virtual-machines-using.html
#>

# This is the configuration object
Configuration WebApp001 {

    # We are importing the module that contains the 'WindowsFeature' and 'File' resources
    Import-DscResource -ModuleName PsDesiredStateConfiguration

    # This is the computer we are targeting, 'localhost' allows us to use the configuration for all machines
    Node 'localhost' {

        # Ensure that the Web-Server feature is installed and enabled.
        WindowsFeature WebServer {
            Ensure = "Present"
            Name   = "Web-Server"
        }
    }
}