



Function New-PleskCustomer {
    Param(
            [Parameter ()]
            [string] $CName = "RSD Inc.",

            [Parameter ()]
            [string] $PName = "Starlin Almonte Peralta",

            [Parameter ()]
            [string] $Login = "RSDInc",

            [Parameter ()]
            [string] $Email = "starlinrsd@gmail.com",

            $H = @{"Content-Type" = "text/xml"; "HTTP_AUTH_LOGIN" = "starlin"; "HTTP_AUTH_PASSWD" = "jUrQ62arRV"}
                        
    )
        

    [XML] $XMLDocument = @”
       
        <customer>
        <add>
            <gen_info>
                <cname>$CName</cname>
                <pname>$PName</pname>
                <login>$Login</login>
                <passwd>Jhtr66fBB</passwd>
                <status>0</status>
                <phone>416 907 9944</phone>
                <fax>928 752 3905</fax>
                <email>$Email</email>
                <address>105 Brisbane Road, Unit 2</address>
                <city>Toronto</city>
                <state/>
                <pcode/>
                <country>CA</country>
            </gen_info>
        </add>
        </customer>
“@

Invoke-WebRequest -URI "https://plesk.rsdtech.net:8443/enterprise/control/agent.php" -Headers $H -Body $XMLDocument -Method:Post -ContentType "application/xml" -ErrorAction:Stop -TimeoutSec 20

}


Function New-PleskSubscription{

       Param(
            
            [Parameter (Mandatory = $true, Position = 0, HelpMessage = "Specifies the personal name of the customer who owns the customer account.")]
            [string] $PName,

            [Parameter (Mandatory = $true, Position = 1, HelpMessage = "Specifies the login name of the customer account.")]
            [string] $Login,

            [Parameter (Mandatory = $true, Position = 2, HelpMessage = "Specifies the password of the customer account.")]
            [string] $Password,

            [Parameter (Mandatory = $true, Position = 3, HelpMessage = "Specifies the primary domain of the customer account.")]
            [string] $Domain,

            [Parameter (HelpMessage = "Specifies the company name.")]
            [string] $CName,

            [Parameter (HelpMessage = "Specifies the phone number of the customer.")]
            [string] $Phone,

            [Parameter (HelpMessage = "Specifies the email address of the customer.")]
            [string] $Email,

            [Parameter (HelpMessage = "Specifies the address of the customer.")]
            [string] $Address,

            [Parameter (HelpMessage = "Specifies the city of the customer.")]
            [string] $City,

            [Parameter (HelpMessage = "Specifies the state of the customer.")]
            [string] $State,

            [Parameter (HelpMessage = "Specifies the postal code of the customer.")]
            [string] $PostalCode,

            [Parameter (HelpMessage = "Specifies the country code of the customer.")]
            [string] $Country = "CA"
            
    )


    Set-Variable -Name H -Option Constant -Value @{"Content-Type" = "text/xml"; "HTTP_AUTH_LOGIN" = "starlin"; "HTTP_AUTH_PASSWD" = "jUrQ62arRV"}
        

#XML Document to create a new customer
    [XML] $XMLDocument = @”
       
        <customer>
        <add>
            <gen_info>
                <cname>$CName</cname>
                <pname>$PName</pname>
                <login>$Login</login>
                <passwd>$Password</passwd>
                <status>0</status>
                <phone>$Phone</phone>
                <email>$Email</email>
                <address>$Address</address>
                <city>$City</city>
                <state>$State<state/>
                <pcode>$PostalCode<pcode/>
                <country>$Country</country>
            </gen_info>
        </add>
        </customer>
“@


$CreatedCustomer = Invoke-WebRequest -URI "https://plesk.rsdtech.net:8443/enterprise/control/agent.php" -Headers $H -Body $XMLDocument -Method:Post -ContentType "application/xml" -ErrorAction:Stop -TimeoutSec 20
$CustomerID = ([XML]$CreatedCustomer.Content).packet.customer.add.result.id


#XML Document to create a subscription and assign it to the customer created in the previous step using the ID property from the WebResponse
    $XMLDocument = @”
       
            <webspace>
            <add>
              <gen_setup>
                <name>$Domain</name>
                <ip_address>10.0.1.4</ip_address>
                <owner-id>$CustomerID</owner-id>
              </gen_setup>
              <hosting>
                <vrt_hst>
                  <property>
                    <name>ftp_login</name>
                    <value>$Login</value>
                  </property>
                  <property>
                    <name>ftp_password</name>
                    <value>$Password</value>
                  </property>
                  <ip_address>10.0.1.4</ip_address>
                </vrt_hst>
              </hosting>
              <plan-name>Unlimited</plan-name>
            </add>
          </webspace>
“@ 

Invoke-WebRequest -URI "https://plesk.rsdtech.net:8443/enterprise/control/agent.php" -Headers $H -Body $XMLDocument -Method:Post -ContentType "application/xml" -ErrorAction:Stop -TimeoutSec 60

}


Function New-PleskUnassignedSubscription {
    Param(
            [Parameter ()]
            [string] $CName = "RSD Inc.",

            [Parameter ()]
            [string] $PName = "Starlin Almonte Peralta",

            [Parameter ()]
            [string] $Login = "RSDInc",

            [Parameter ()]
            [string] $Email = "starlinrsd@gmail.com",

            $H = @{"Content-Type" = "text/xml"; "HTTP_AUTH_LOGIN" = "starlin"; "HTTP_AUTH_PASSWD" = "jUrQ62arRV"}
                        
    )
        

    [XML] $XMLDocument = @”
       
            <webspace>
            <add>
              <gen_setup>
                <name>$Domain</name>
                <ip_address>10.0.1.4</ip_address>
                <owner-id>$CustomerID</owner-id>
              </gen_setup>
              <hosting>
                <vrt_hst>
                  <property>
                    <name>ftp_login</name>
                    <value>$Login</value>
                  </property>
                  <property>
                    <name>ftp_password</name>
                    <value>Rsd062316.</value>
                  </property>
                  <ip_address>10.0.1.4</ip_address>
                </vrt_hst>
              </hosting>
              <plan-name>Unlimited</plan-name>
            </add>
          </webspace>
“@ 

$R  = Invoke-WebRequest -URI "https://plesk.rsdtech.net:8443/enterprise/control/agent.php" -Headers $H -Body $XMLDocument -Method:Post -ContentType "application/xml" -ErrorAction:Stop -TimeoutSec 60

}
