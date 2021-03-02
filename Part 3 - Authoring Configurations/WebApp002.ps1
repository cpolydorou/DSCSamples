Configuration WebApp002 {
    # Parameters
    Param
    (
        [int]$Port = 8080
    )

    # Import the modules that contains the resources we're using.
    Import-DscResource -ModuleName PsDesiredStateConfiguration
    Import-DscResource -ModuleName xNetworking
    Import-DscResource -ModuleName xWebAdministration

    # The Node statement specifies which targets this configuration will be applied to.
    Node 'localhost' {

        # The first resource block ensures that the Web-Server (IIS) feature is enabled.
        WindowsFeature WebServer {
            Ensure = "Present"
            Name   = "Web-Server"
        }

        WindowsFeature WebServerManagement {
            Ensure = 'Present'
            Name   = "Web-Mgmt-Console"
            DependsOn = '[WindowsFeature]WebServer'
        }

        xWebAppPool AppPool {
            Ensure    = "Present"
            Name      = "MySiteAppPool"
            startMode = 'AlwaysRunning'
            DependsOn = '[WindowsFeature]WebServer'
        }

        # The second resource block ensures that the website content copied to the website root folder.
        File WebSiteContent {
            Ensure          = 'Present'
            SourcePath      = '\\fileserver\dsc\WebApp001\iisstart.htm'
            DestinationPath = 'C:\inetpub\MySite\iisstart.htm'
            Checksum        = "modifiedDate"
            Force           = $true
            MatchSource     = $true
        }

        xWebSite WebSite {
            Ensure          = "Present"
            Name            = "MySite"
            PhysicalPath    = 'C:\inetpub\MySite'
            ApplicationPool = "MySiteAppPool"
            BindingInfo     = @( MSFT_xWebBindingInformation
                                 {
                                   Protocol = "HTTP"
                                   Port     = $Port
                                 }
                            )
            DependsOn       = '[xWebAppPool]AppPool','[File]WebSiteContent'
        }
        
        xFirewall AllowWebSite {
            Ensure    = 'Present'
            Name      = "Allow My Website"
            Enabled   = 'True'
            Action    = 'Allow'
            LocalPort = $Port
            Protocol  = 'TCP'
        }        
    }
}