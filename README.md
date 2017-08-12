# icinga-o365-plugin
A set of Office 365 status check scripts for icinga plugin

################################
check_sharepoint.ps1

Options:
    -u: username
    -p: password
    -d: domain name (e.g., office.com)
    -a: application errors, -pid: Product ID REQUIRED
    -i: all installed applications, -pid: Product ID, -app: Application name, -i REQUIRES either -pid or -app
    -s: site collections
    -t: tenant properties
    -l: tenant logs
    Example:
    ./check_sharepoint -u admin@office365.com -p adminpassword -d "companydomain" -s}
    
################################
