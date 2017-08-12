# This plugin is to check SharePoint Online status
# Please feel free to add extra services or PowerShell cmdlet as needed
# Author: Takaki Matsumoto
# Version: 1.0

Import-Module MSOnline
Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking

param (
    [Parameter(Mandatory=$true)[string]$u,
    [Parameter(Mandatory=$true)[string]$p,
    [Parameter(Mandatory=$true)[string]$d,
    [bool]$a,
    [string]$pid,
    [string]$app
    [bool]$i,
    [bool]$s,
    [bool]$t,
    [bool]$l,
    [bool]$h
 )


switch ($h)
{
    $true { echo "Options: `n
    -u: username`n
    -p: password`n
    -d: domain name (e.g., office.com)`n
    -a: application errors, -pid: Product ID REQUIRED`n
    -i: all installed applications, -pid: Product ID, -app: Application name, -i REQUIRES either -pid or -app`n
    -s: site collections`n
    -t: tenant properties`n
    -l: tenant logs`n 
    Example:`n
    ./check_sharepoint -u admin@office365.com -p adminpassword -d "companydomain" -s}
}

#connect to SharePoint Site using -d
function msolconnect
    \{
    # connect to O365 API using -u, -p, and -d.
    
    $cred = New-Object -TypeName System.Management.Automation.PSCredential`
    -argumentlist $u, $(convertto-securestring $p -asplaintext -force)
    
    Connect-SPOService -Url https://$d-admin.sharepoint.com -credential $cred
    \}

# -a
function apperrors
    \{
    
    Get-SPOapperrors -ProductID $pid
    
    \}
        

# -i
function appinfo1
    \{
    
    GET-SPOAppinfo -Name $app
    
    \}

function appinfo2
    \{
    
    GET-SPOAppInfo -ProductID $pid
    
    \}

# -s
function site
    \{       
    
    Get-SPOSite -Identity https://$d-admin.sharepoint.com
    
    \}

# -t
function tenant 
    \{
    
    Get-SPOTenant
    
    \}

# -l
function logentry
    \{

    Get-SPOTenantlogentry

    \}

# Connect to SharePoint Online
msolconnect

# Apperror check
if ($a -eq $true -and $pid -notlike "") {
    
    apperrors
    
    }
    
elif ($a -eq $true -and $pid -eq ""){
    
    echo "Product ID REQUIRED"

}

# Appinfo based on Product ID
if ($i -eq $true -and $pid -notlike "") {
    
    appinfo1

}
    
# Appinfo based on App Name
if ($i -eq $true -and $app -notlike "") {
    
    appinfo2

}

if ($i -eq true -and $app -eq "" -and $pid -eq "") {
    
    echo "Application Name or Product ID is required for Application info"

}


if (-s -eq $true){
    
    site

}

if (-t -eq $true){
    
    tenant

}

if (-l -eq $true){
    
    logentry

}  
      
                        
exit
