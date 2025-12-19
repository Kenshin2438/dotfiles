param (
    [string]$Template = "config.yaml.tmpl",
    [string]$Output   = "config.yaml",
    [switch]$buildMihomoLauncher
)

# Converts a SecureString to plain text while ensuring secure memory cleanup
# The BSTR is zeroed before being freed to prevent credential exposure in memory
function Get-SecureStringValue {
    param ([SecureString]$SecureString)

    $bstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString)
    try {
        return [Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
    } finally {
        # Zero out the BSTR memory before freeing to prevent credential leakage
        [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)
    }
}

function main {
    # Step 1. Prompt user for provider URL (input is masked for security)
    Write-Host "URL: " -ForegroundColor Cyan -NoNewline
    $secureUrl = Read-Host -AsSecureString

    # Step 2. Convert secure string to plain text for template replacement
    $providerUrl = Get-SecureStringValue -SecureString $secureUrl

    # Step 3. Replace placeholder in template and write to output file
    (Get-Content $Template -Raw).Replace("__PROVIDER_URL__", $providerUrl) |
        Set-Content -Path $Output -Encoding UTF8

    # Step 4. build noGUI MihomoLauncher
    if ($buildMihomoLauncher) {
        Invoke-PS2EXE -inputFile .\MihomoLauncher.ps1 -outputFile .\MihomoLauncher.exe -noConsole -requireAdmin
    }
}

try {
    Push-Location $PSScriptRoot
    main
} finally {
    Pop-Location
}
