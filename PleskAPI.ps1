



Function New-PleskCustomer {
    param(
        
    )

    [XML] $XMLDoc = @”
    <packet version="1.6.7.0">
    <customer>
    <add>
        <gen_info>
            <cname>LogicSoft Ltd.</cname>
            <pname>Stephen Lowell</pname>
            <login>stevelow</login>
            <passwd>Jhtr66fBB</passwd>
            <status>0</status>
            <phone>416 907 9944</phone>
            <fax>928 752 3905</fax>
            <email>host@logicsoft.net</email>
            <address>105 Brisbane Road, Unit 2</address>
            <city>Toronto</city>
            <state/>
            <pcode/>
            <country>CA</country>
        </gen_info>
    </add>
    </customer>
    </packet>
“@

}