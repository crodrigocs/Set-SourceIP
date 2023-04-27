param(
    [Parameter()]
    [string[]] $IPAddress,
    [Parameter()]
    [switch] $Reset
)

$IPs = Get-NetAdapter | Get-NetIPAddress | Select-Object -expand IPAddress

if ($IPAddress) {

    foreach ($IP in $IPs) {
        Set-NetIPAddress -IPAddress $IP -SkipAsSource $true
    }

    Set-NetIPAddress -IPAddress $IPAddress -SkipAsSource $false

}

if ($Reset) {

    foreach ($IP in $IPs) {
        Set-NetIPAddress -IPAddress $IP -SkipAsSource $false
    }

}

Get-NetAdapter | Get-NetIPAddress | Select-Object IPAddress, SkipAsSource