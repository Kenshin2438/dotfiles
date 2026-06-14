Get-Process -Name 'mihomo' -ErrorAction SilentlyContinue | Stop-Process
Start-Process mihomo -WindowStyle Hidden -Verb RunAs
