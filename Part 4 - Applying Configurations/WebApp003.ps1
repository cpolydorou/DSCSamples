<#
    Author  : Christos Polydorou
    Date    : March 10 2021
    Purpose : DSC Configuration example
    URL     : https://blog.cpolydorou.net/2021/03/configuring-virtual-machines-using_16.html
#>

# This is the configuration object
Configuration WebApp003 {

    # We are importing the module that contains the 'WindowsFeature' and 'File' resources
    Import-DscResource -ModuleName PsDesiredStateConfiguration

    # This is the computer we are targeting, 'localhost' allows us to use the configuration for all machines
    Node 'localhost' {

        # Ensure that the Web-Server feature is installed and enabled.
        WindowsFeature WebServer {
            Ensure = "Present"
            Name   = "Web-Server"
        }

        # Make sure that the web page file is copied to the website root folder.
        File WebsiteContent {
            Ensure = 'Present'
            SourcePath = '\\fileserver\dsc\WebApp001\iisstart.htm'
            DestinationPath = 'c:\inetpub\wwwroot'
            Checksum = "modifiedDate"
            Force = $true
            MatchSource = $true
            DependsOn = '[WindowsFeature]WebServer'
        }
    }
}