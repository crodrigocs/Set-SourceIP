
<#PSScriptInfo

.VERSION 1.0

.GUID 26d275c5-b502-4cda-b33c-481280dadfbe

.AUTHOR Rodrigo Silva

.COMPANYNAME rdgo.dev

.COPYRIGHT (c) 2023 Rodrigo Silva. All rights reserved.

.TAGS SkipAsSource, Set-NetIPAddress

.LICENSEURI https://github.com/crodrigocs/Set-SourceIP/blob/main/LICENSE

.PROJECTURI https://github.com/crodrigocs/Set-SourceIP

.ICONURI 

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES Initial release


#>

<# 

.DESCRIPTION 
 This script sets a preferred IP as the source or primary IP on a multiple IP address scenario.
.SYNOPSIS
 Set preferred source IP
.LINK
 https://rdgo.dev
 https://github.com/crodrigocs/Set-SourceIP
.PARAMETER IPAddress
 Specify the IP address to be used as the source IP.
.PARAMETER Reset
 Reset the adapter to its default settings.
.EXAMPLE
 .\Set-SourceIP.ps1
 This will show the list of IPs and their respective "SkipAsSource" status.
.EXAMPLE
 .\Set-SourceIP.ps1 -IPAddress 192.168.0.28
 This will set 192.168.0.28 as the source IP for outbound connections.
.EXAMPLE
 .\Get-IPList.ps1 -Reset
 This will reset the adapter to its default setting.

#> 

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
