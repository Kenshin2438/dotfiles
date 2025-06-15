## Shell Ptompt
$env:STARSHIP_CONFIG = "$HOME\.config\starship.toml"
Invoke-Expression (&starship init powershell)

## PSReadline
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

## Proxy
Function Enable-Proxy {
    Param([ValidateSet(7897, 2080)] $port)

    [String] $proxy = "http://127.0.0.1:${port}"
    Write-Output "`e[2m[Proxy ON] ALL_PROXY, HTTPS_PROXY and HTTP_PROXY set to $proxy.`e[0m"
    Set-Item env:ALL_PROXY $proxy
    Set-Item env:HTTP_PROXY $proxy
    Set-Item env:HTTPS_PROXY $proxy
    Set-Item env:NO_PROXY "localhost,127.0.0.1,::1,192.168.0.0/16"
}
Function Disable-Proxy {
    if ($env:ALL_PROXY) { Remove-Item env:ALL_PROXY }
    if ($env:HTTP_PROXY) { Remove-Item env:HTTP_PROXY }
    if ($env:HTTPS_PROXY) { Remove-Item env:HTTPS_PROXY }
    if ($env:NO_PROXY) { Remove-Item env:NO_PROXY }
    Write-Output "`e[2m[Proxy OFF] unset ALL_PROXY, HTTPS_PROXY and HTTP_PROXY.`e[0m"
}

## PowerToys CommandNotFound suggestions
Import-Module -Name Microsoft.WinGet.CommandNotFound

## Fast scoop search drop-in replacement
Invoke-Expression (&scoop-search --hook)
