## Prompt
Invoke-Expression (&starship init powershell)

## PSReadline Configuration
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineOption -Colors @{
  InlinePrediction = $PSStyle.Italic + $PSStyle.Foreground.BrightBlack
}

## Proxy Management Functions
# Set proxy environment variables for HTTP/HTTPS traffic
function Enable-Proxy {
  [String] $proxy = "http://127.0.0.1:7890"
  Write-Host "[Proxy ON] ALL_PROXY, HTTPS_PROXY and HTTP_PROXY set to $proxy." -ForegroundColor DarkGray
  Set-Item env:ALL_PROXY $proxy
  Set-Item env:HTTP_PROXY $proxy
  Set-Item env:HTTPS_PROXY $proxy
  Set-Item env:NO_PROXY "localhost,127.0.0.1,::1,192.168.0.0/16"
}
# Disables proxy settings by removing all proxy-related environment variables
function Disable-Proxy {
  if ($env:ALL_PROXY) { Remove-Item env:ALL_PROXY }
  if ($env:HTTP_PROXY) { Remove-Item env:HTTP_PROXY }
  if ($env:HTTPS_PROXY) { Remove-Item env:HTTPS_PROXY }
  if ($env:NO_PROXY) { Remove-Item env:NO_PROXY }
  Write-Host "[Proxy OFF] unset ALL_PROXY, HTTPS_PROXY and HTTP_PROXY." -ForegroundColor DarkGray
}

## OpenCode
Set-Item env:OPENCODE_EXPERIMENTAL_BACKGROUND_SUBAGENTS "true"
